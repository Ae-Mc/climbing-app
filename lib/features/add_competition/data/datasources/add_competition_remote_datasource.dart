import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/add_competition/domain/entities/competition_create.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'add_competition_remote_datasource.g.dart';

@singleton
class AddCompetitionRemoteDatasource {
  final AddCompetitionApi api;

  AddCompetitionRemoteDatasource(this.api);

  Future<void> addCompetition(CompetitionCreate competition) =>
      api.addCompetition(competition);
}

@RestApi(baseUrl: '$apiHostUrl/api/v1')
@singleton
abstract class AddCompetitionApi {
  @factoryMethod
  factory AddCompetitionApi(Dio dio) => _AddCompetitionApi(dio);

  @POST('/competitions')
  @FormUrlEncoded()
  Future<void> addCompetition(@Body() CompetitionCreate competition);
}
