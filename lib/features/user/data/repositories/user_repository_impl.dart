import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
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
  AccessToken? accessToken;

  UserRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, User>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
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
      GetIt.I<Logger>().d(accessToken);

      return const Right(null);
    } on DioError catch (error) {
      return Left(
        handleDioConnectionError(error)
            .fold<Either<Failure, LoginFailure>>((l) => Left(l), (error) {
          final response = error.response;

          if (response == null) {
            GetIt.I<Logger>().e('Unknown error: ', error);

            return const Left(UnknownFailure());
          }

          if (response.statusCode == 400) {
            final Map<String, dynamic> jsonResponse = response.data;
            if (jsonResponse["detail"] == "LOGIN_BAD_CREDENTIALS") {
              return const Right(LoginFailure.badCredentials());
            }
            if (jsonResponse["detail"] == "LOGIN_USER_NOT_VERIFIED") {
              return const Right(LoginFailure.userNotVerified());
            }
          } else if (response.statusCode == 422) {
            final Map<String, dynamic> jsonResponse = response.data;
            final List? details = jsonResponse["detail"];
            if (details != null) {
              final parsingResult = parseValidationError(details);
              if (parsingResult != null) {
                return Right(parsingResult);
              }
            }
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
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
