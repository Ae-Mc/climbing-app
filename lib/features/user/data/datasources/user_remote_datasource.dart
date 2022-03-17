import 'package:climbing_app/features/user/data/models/access_token.dart';

abstract class UserRemoteDatasource {
  Future<AccessToken> login(String usernameOrEmail, String password);
}
