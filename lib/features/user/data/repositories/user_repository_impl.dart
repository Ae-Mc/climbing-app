import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:climbing_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/domain/entities/login_failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;
  final UserLocalDatasource localDatasource;
  AccessToken? accessToken;

  UserRepositoryImpl(this.remoteDatasource, this.localDatasource, Dio dio) {
    dio.interceptors.add(AuthorizationInterceptor(() => accessToken));
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    assert(isAuthenticated);

    try {
      return Right(await remoteDatasource.getCurrentUser());
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold((l) => l, (r) {
        return const UnknownFailure();
      }));
    }
  }

  @override
  bool get isAuthenticated => accessToken != null;

  @override
  Future<Either<Either<Failure, LoginFailure>, void>> login(
    String usernameOrEmail,
    String password,
  ) async {
    try {
      // TODO: implement token saving and loading from storage on app startup
      accessToken = await remoteDatasource.login(usernameOrEmail, password);

      return const Right(null);
    } on DioError catch (error) {
      return Left(
        handleDioConnectionError(error)
            .fold<Either<Failure, LoginFailure>>((l) => Left(l), (error) {
          final statusCode = error.response?.statusCode;
          final Map<String, dynamic>? jsonResponse = error.response?.data;

          if (statusCode == null || jsonResponse == null) {
            GetIt.I<Logger>().e('Unknown error: ', error);

            return const Left(UnknownFailure());
          }

          if (statusCode == 400) {
            if (jsonResponse["detail"] == "LOGIN_BAD_CREDENTIALS") {
              return const Right(LoginFailure.badCredentials());
            }
            if (jsonResponse["detail"] == "LOGIN_USER_NOT_VERIFIED") {
              return const Right(LoginFailure.userNotVerified());
            }
          } else if (statusCode == 422) {
            final List? details = jsonResponse["detail"];
            if (details != null) {
              final parsingResult = parseValidationError(details);
              if (parsingResult != null) {
                return Right(parsingResult);
              }
            }
          } else if (statusCode >= 499 && statusCode < 600) {
            return Left(Failure.serverFailure(statusCode: statusCode));
          }

          GetIt.I<Logger>().e('Unknown error: ', error);

          return const Left(UnknownFailure());
        }),
      );
    }
  }

  LoginFailure? parseValidationError(final List details) {
    if (details.isEmpty) {
      return null;
    }

    GetIt.I<Logger>().d(details);
    final detail = details.first;

    if (detail["msg"] == null) {
      return null;
    }

    if (detail["msg"] == "field required") {
      final List? loc = detail["loc"];
      if (loc == null) {
        return null;
      }

      switch (loc.last) {
        case "username":
          return const LoginFailure.validationError(
            'Поле имя не может быть пустым',
          );
        case "password":
          return const LoginFailure.validationError(
            'Поле пароль не может быть пустым',
          );
        default:
          return LoginFailure.validationError(
            "Поле не может быть пустым: ${detail['loc'][0]}",
          );
      }
    } else {
      return LoginFailure.validationError(detail["msg"]);
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDatasource.logout();

      return Right(accessToken = null);
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold<Failure>(
        (l) => l,
        (r) {
          final response = r.response;
          final statusCode = response?.statusCode;

          if (statusCode == null || response == null) {
            return const Failure.unknownFailure();
          }

          if (statusCode >= 500 && statusCode < 600) {
            return Failure.serverFailure(statusCode: statusCode);
          }

          GetIt.I<Logger>().d(
            'Error occured with status code: $statusCode. ${response.data}',
          );

          return const Failure.unknownFailure();
        },
      ));
    }
  }
}

class AuthorizationInterceptor extends Interceptor {
  final AccessToken? Function() getAccessToken;

  AuthorizationInterceptor(this.getAccessToken);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null && response.statusCode == 499) {
      // TODO: refresh token if expired
    } else {
      handler.next(err);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getAccessToken();
    if (token != null) {
      options.headers['Authorization'] =
          '${token.tokenType} ${token.accessToken}';
    }
    handler.next(options);
  }
}
