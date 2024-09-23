import 'package:climbing_app/core/constants.dart';
import 'package:climbing_app/features/competitions/data/datasources/competitions_datasource.dart';
import 'package:climbing_app/features/competitions/domain/entities/competition_create.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'competitions_datasource_impl.g.dart';

@Singleton(as: CompetitionsDatasource)
class CompetitionsDatasourceImpl implements CompetitionsDatasource {
  final CompetitionsApi api;

  CompetitionsDatasourceImpl(this.api);

  @override
  Future<List<CompetitionRead>> getCurrentUserCompetitions() =>
      api.getCurrentUserCompetitions();

  @override
  Future<void> addCompetition(CompetitionCreate competition) =>
      api.addCompetition(competition);

  @override
  Future<void> removeCompetition(String competitionId) =>
      api.removeCompetition(competitionId);
}

@singleton
@RestApi(baseUrl: '$apiHostUrl/api/v1/')
abstract class CompetitionsApi {
  @factoryMethod
  factory CompetitionsApi(Dio dio) => _CompetitionsApi(dio);

  @POST('/competitions')
  Future<void> addCompetition(@Body() CompetitionCreate competition);

  @GET("users/me/competitions")
  Future<List<CompetitionRead>> getCurrentUserCompetitions();

  @DELETE('/competitions/{competition_id}')
  Future<void> removeCompetition(@Path("competition_id") String id);
}
