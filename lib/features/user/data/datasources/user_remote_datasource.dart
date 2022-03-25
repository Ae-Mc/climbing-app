import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';

abstract class UserRemoteDatasource {
  Future<User> getCurrentUser();
  Future<AccessToken> signIn(String usernameOrEmail, String password);
  Future<void> signOut();
  Future<User> register(UserCreate userCreate);
}
