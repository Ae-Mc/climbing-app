import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/add_ascent/domain/entities/ascent.dart';
import 'package:climbing_app/features/add_ascent/domain/entities/ascent_create.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'add_ascent_remote_datasource.g.dart';

@singleton
class AddAscentRemoteDatasource {
  final AddAscentApi api;

  AddAscentRemoteDatasource(this.api);

  Future<Ascent> addAscent(AscentCreate ascent) => api.addAscent(ascent);
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v1')
abstract class AddAscentApi {
  @factoryMethod
  factory AddAscentApi(Dio dio) => _AddAscentApi(dio);

  @POST('/ascents')
  // @FormUrlEncoded()
  Future<Ascent> addAscent(@Body() AscentCreate ascent);
}
