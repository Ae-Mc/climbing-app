import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'rating_remote_datasource.g.dart';

@singleton
class RatingRemoteDatasource {
  final RatingApi api;

  RatingRemoteDatasource(this.api);

  Future<List<Score>> getRating(bool mustBeStudent, bool mustBeFemale) => api
      .getRating(mustBeStudent ? true : null, mustBeFemale ? "female" : null);

  Future<List<AscentRead>> getUserRatingAscents(String userId) =>
      api.getUserRatingAscents(userId);
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v2')
abstract class RatingApi {
  @factoryMethod
  factory RatingApi(Dio dio) => _RatingApi(dio);

  @GET('/rating')
  Future<List<Score>> getRating(
      [@Query("is_student") bool? isStudent, @Query("sex") String? sex]);

  @GET('/rating/user/{user_id}/ascents')
  Future<List<AscentRead>> getUserRatingAscents(@Path("user_id") String userId);
}
