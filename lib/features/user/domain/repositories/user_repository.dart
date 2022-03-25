import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/login_failure.dart';
import 'package:climbing_app/features/user/domain/entities/sign_up_failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  bool get isAuthenticated;

  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Either<Failure, LoginFailure>, void>> login(
    String usernameOrEmail,
    String password,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Either<Failure, SignUpFailure>, void>> register(
    UserCreate userCreate,
  );
}
