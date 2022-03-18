import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/login_failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  bool get isAuthenticated;

  Future<Either<Either<Failure, LoginFailure>, void>> login(
    String usernameOrEmail,
    String password,
  );
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> getCurrentUser();
}
