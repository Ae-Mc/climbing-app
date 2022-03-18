import 'dart:convert';

import 'package:climbing_app/features/user/data/datasources/user_local_datasource.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton(as: UserLocalDatasource)
class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences sharedPreferences;

  UserLocalDatasourceImpl(this.sharedPreferences);

  @override
  AccessToken? loadToken() {
    final token = sharedPreferences.getString("accessToken");

    return token == null ? null : AccessToken.fromJson(jsonDecode(token));
  }

  @override
  Future<void> saveToken(AccessToken? accessToken) async {
    if (accessToken == null) {
      // ignore: avoid-ignoring-return-values
      await sharedPreferences.remove("accessToken");
    } else {
      // ignore: avoid-ignoring-return-values
      await sharedPreferences.setString(
        "accessToken",
        jsonEncode(accessToken.toJson()),
      );
    }
  }
}
