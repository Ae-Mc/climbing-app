import 'package:climbing_app/features/add_ascent/domain/entities/ascent.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';

abstract class UserRemoteDatasource {
  Future<List<User>> getAllUsers();
  Future<User> getCurrentUser();
  Future<List<Ascent>> getCurrentUserAscents();
  Future<List<Route>> getCurrentUserRoutes();
  Future<AccessToken> signIn(String usernameOrEmail, String password);
  Future<void> signOut();
  Future<User> register(UserCreate userCreate);
  Future<List<ExpiringAscent>> getCurrentUserExpiringAscents();
}
