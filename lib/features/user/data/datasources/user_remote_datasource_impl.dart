import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'user_remote_datasource_impl.g.dart';

@Singleton(as: UserRemoteDatasource)
class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final AuthApi authApi;

  UserRemoteDatasourceImpl(this.authApi);

  @override
  Future<User> getCurrentUser() => authApi.getCurrentUser();

  @override
  Future<AccessToken> login(String usernameOrEmail, String password) =>
      authApi.login(usernameOrEmail, password);

  @override
  Future<void> logout() => authApi.logout();

  @override
  Future<User> register(UserCreate userCreate) => authApi.register(userCreate);
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v1/')
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) => _AuthApi(dio);

  @GET("users/me")
  Future<User> getCurrentUser();

  @POST("auth/login")
  @FormUrlEncoded()
  Future<AccessToken> login(@Field() String username, @Field() String password);

  @POST("auth/logout")
  Future<void> logout();

  @POST("auth/register")
  // ignore: long-parameter-list
  Future<User> register(@Body() UserCreate userCreate);
}
