import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:climbing_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/data/models/validation_error.dart';
import 'package:climbing_app/features/user/domain/entities/sign_in_failure.dart';
import 'package:climbing_app/features/user/domain/entities/register_failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';
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
    dio.interceptors.add(AuthorizationInterceptor(
      getAccessToken: () => accessToken,
      on401Response: (error, handler) async {
        accessToken = null;
        await localDatasource.saveToken(accessToken);
        if (error.requestOptions.headers['Authorization'] == null) {
          handler.next(error);
        } else {
          final newRequestOptions = error.requestOptions.copyWith();
          // ignore: avoid-ignoring-return-values
          newRequestOptions.headers.remove('Authorization');
          try {
            handler.resolve(await dio.fetch(newRequestOptions));
          } on DioError catch (error) {
            handler.next(error);
          }
        }
      },
    ));
    accessToken = localDatasource.loadToken();
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    assert(isAuthenticated);

    try {
      return Right(await remoteDatasource.getAllUsers());
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold(
        (l) => l,
        (r) {
          return const UnknownFailure();
        },
      ));
    }
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
  Future<Either<Either<Failure, SignInFailure>, void>> signIn(
    String usernameOrEmail,
    String password,
  ) async {
    try {
      accessToken = await remoteDatasource.signIn(usernameOrEmail, password);
      await localDatasource.saveToken(accessToken);

      return const Right(null);
    } on DioError catch (error) {
      return Left(
        handleDioConnectionError(error)
            .fold<Either<Failure, SignInFailure>>((l) => Left(l), (error) {
          final statusCode = error.response?.statusCode;
          final Map<String, dynamic>? jsonResponse = error.response?.data;

          if (statusCode == null || jsonResponse == null) {
            GetIt.I<Logger>().e('Unknown error: ', error);

            return const Left(UnknownFailure());
          }

          if (statusCode == 400) {
            if (jsonResponse["detail"] == "LOGIN_BAD_CREDENTIALS") {
              return const Right(SignInFailure.badCredentials());
            }
            if (jsonResponse["detail"] == "LOGIN_USER_NOT_VERIFIED") {
              return const Right(SignInFailure.userNotVerified());
            }
          } else if (statusCode == 422) {
            final validationError = ValidationError.fromJson(jsonResponse);
            final errorText = parseValidationError(validationError);
            if (errorText != null) {
              return Right(SignInFailure.validationError(errorText));
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

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDatasource.signOut();
      accessToken = null;
      await localDatasource.saveToken(accessToken);

      return const Right(null);
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

  @override
  Future<Either<Either<Failure, RegisterFailure>, void>> register(
    UserCreate userCreate,
  ) async {
    try {
      // ignore: avoid-ignoring-return-values
      await remoteDatasource.register(userCreate);

      return const Right(null);
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error)
          .fold<Either<Failure, RegisterFailure>>((l) => Left(l), (r) {
        final response = r.response;
        final statusCode = response?.statusCode;

        if (response == null) {
          return const Left(Failure.unknownFailure());
        }

        if (statusCode == 422) {
          final validationError = ValidationError.fromJson(response.data);
          GetIt.I<Logger>().e('Dio error: $validationError');
          final errorText = parseValidationError(validationError);

          if (errorText != null) {
            return Right(RegisterFailure.validationError(errorText));
          }
        } else if (statusCode == 400) {
          final result = response.data;
          if (result["detail"] != null) {
            if (result["detail"] is Map &&
                result["detail"]["code"] == "REGISTER_INVALID_PASSWORD") {
              return Right(
                RegisterFailure.invalidPassword(result["detail"]["reason"]),
              );
            } else if (result["detail"] == "REGISTER_USER_ALREADY_EXISTS") {
              return const Right(RegisterFailure.userAlreadyExists());
            }
          }
          GetIt.I<Logger>().e('Result: ${response.data}');
        }

        GetIt.I<Logger>().e('Unexpected error: $response');

        return const Left(Failure.unknownFailure());
      }));
    }
  }

  static String? parseValidationError(
    ValidationError validationError, [
    Map<String, String> remoteToLocalFieldNameDict = remoteToLocalFieldNameDict,
  ]) {
    for (final detail in validationError.detail) {
      final numberRegex = RegExp(r'\d+');
      final localFieldName = remoteToLocalFieldNameDict[detail.loc.last];
      final fieldName = localFieldName ?? detail.loc.last;

      switch (detail.type) {
        case "value_error.missing":
          return "Поле $fieldName не может быть пустым";
        case "value_error.any_str.min_length":
          final minCharacters = numberRegex.stringMatch(detail.msg);
          if (minCharacters == null) {
            throw Error();
          }

          return "Поле $fieldName не может быть короче $minCharacters символов";
        case "value_error.any_str.max_length":
          final maxCharacters = numberRegex.stringMatch(detail.msg);
          if (maxCharacters == null) {
            throw Error();
          }

          return "Поле $fieldName не может быть длиннее $maxCharacters символов";
        case "value_error.email":
          return "Поле $fieldName не соответствует формату Email";
        default:
          return detail.msg;
      }
    }

    return null;
  }

  static const remoteToLocalFieldNameDict = {
    "email": "email",
    "first_name": "имя",
    "last_name": "фамилия",
    "password": "пароль",
    "username": "имя пользователя",
  };
}

class AuthorizationInterceptor extends Interceptor {
  final AccessToken? Function() getAccessToken;
  final Future<void> Function(DioError error, ErrorInterceptorHandler handler)?
      on401Response;

  AuthorizationInterceptor({
    required this.getAccessToken,
    this.on401Response,
  });

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.type == DioErrorType.response && err.response?.statusCode == 401) {
      await on401Response?.call(err, handler);
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
