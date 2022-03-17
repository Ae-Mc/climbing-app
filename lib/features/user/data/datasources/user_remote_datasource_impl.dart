import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'user_remote_datasource_impl.g.dart';

@Singleton(as: UserRemoteDatasource)
class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final AuthApi authApi;

  UserRemoteDatasourceImpl(this.authApi);

  @override
  Future<AccessToken> login(String usernameOrEmail, String password) async {
    return await authApi.login(usernameOrEmail, password);
  }
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v1/')
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) => _AuthApi(dio);

  @POST("auth/login")
  @FormUrlEncoded()
  Future<AccessToken> login(@Field() String username, @Field() String password);
}
