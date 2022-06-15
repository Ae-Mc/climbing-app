import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
import 'package:climbing_app/features/user/domain/entities/sign_in_failure.dart';
import 'package:climbing_app/features/user/domain/entities/register_failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  bool get isAuthenticated;

  Future<Either<Failure, List<Route>>> getCurrentUserRoutes();
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Either<Failure, SignInFailure>, void>> signIn(
    String usernameOrEmail,
    String password,
  );
  Future<Either<Failure, void>> signOut();
  Future<Either<Either<Failure, RegisterFailure>, void>> register(
    UserCreate userCreate,
  );
  Future<Either<Failure, List<ExpiringAscent>>> getCurrentUserExpiringAscents();
}
