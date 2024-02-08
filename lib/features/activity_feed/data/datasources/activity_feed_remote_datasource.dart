import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/core/entities/ascent.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'activity_feed_remote_datasource.g.dart';

@singleton
class ActivityFeedRemoteDatasource {
  final ActivityFeedApi api;

  ActivityFeedRemoteDatasource(this.api);
  Future<List<Ascent>> recentAscents() async => api.recentAscents();
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v1/')
abstract class ActivityFeedApi {
  @factoryMethod
  factory ActivityFeedApi(Dio dio) => _ActivityFeedApi(dio);

  @GET('ascents/recent')
  Future<List<Ascent>> recentAscents();
}
