import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/user/data/datasources/user_remote_datasource.dart';
import 'package:climbing_app/features/user/data/models/access_token.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
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
  Future<List<User>> getAllUsers() => authApi.getAllUsers();

  @override
  Future<User> getCurrentUser() => authApi.getCurrentUser();

  @override
  Future<List<Route>> getCurrentUserRoutes() => authApi.getCurrentUserRoutes();

  @override
  Future<List<Ascent>> getCurrentUserAscents() =>
      authApi.getCurrentUserAscents();

  @override
  Future<AccessToken> signIn(String usernameOrEmail, String password) =>
      authApi.signIn(usernameOrEmail, password);

  @override
  Future<void> signOut() => authApi.signOut();

  @override
  Future<User> register(UserCreate userCreate) => authApi.register(userCreate);

  @override
  Future<List<ExpiringAscent>> getCurrentUserExpiringAscents() =>
      authApi.getCurrentUserExpiringAscents();

  @override
  Future<void> forgotPassword(String email) => authApi.forgotPassword(email);

  @override
  Future<void> resetPassword(String token, String password) =>
      authApi.resetPassword(token, password);

  @override
  Future<void> removeAscent(String id) => authApi.removeAscent(id);
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v1/')
abstract class AuthApi {
  @factoryMethod
  factory AuthApi(Dio dio) => _AuthApi(dio);

  @GET("users")
  Future<List<User>> getAllUsers();

  @GET("users/me")
  Future<User> getCurrentUser();

  @GET("users/me/routes")
  Future<List<Route>> getCurrentUserRoutes();

  @GET("users/me/ascents")
  Future<List<Ascent>> getCurrentUserAscents();

  @GET("users/me/ascents/expiring")
  Future<List<ExpiringAscent>> getCurrentUserExpiringAscents();

  @DELETE("ascents/{id}")
  Future<void> removeAscent(@Path("id") String id);

  @POST("auth/login")
  @FormUrlEncoded()
  Future<AccessToken> signIn(
    @Field() String username,
    @Field() String password,
  );

  @POST("auth/logout")
  Future<void> signOut();

  @POST("auth/register")
  Future<User> register(@Body() UserCreate userCreate);

  @POST("auth/forgot-password")
  Future<void> forgotPassword(@Field('email') String email);

  @POST("auth/reset-password")
  Future<void> resetPassword(
    @Field('token') String token,
    @Field('password') String password,
  );
}
