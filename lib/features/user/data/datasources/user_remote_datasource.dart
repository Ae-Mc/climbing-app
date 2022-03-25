import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';

abstract class UserRemoteDatasource {
  Future<User> getCurrentUser();
  Future<AccessToken> login(String usernameOrEmail, String password);
  Future<void> logout();
  Future<User> register(UserCreate userCreate);
}
