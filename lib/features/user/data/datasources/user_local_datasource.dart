import 'package:climbing_app/features/user/data/models/access_token.dart';

abstract class UserLocalDatasource {
  AccessToken? loadToken();
  Future<void> saveToken(AccessToken? accessToken);
}
