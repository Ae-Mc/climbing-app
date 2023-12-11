import 'package:climbing_app/features/competitions/domain/entities/competition_create.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';

abstract class CompetitionsDatasource {
  Future<void> addCompetition(CompetitionCreate competition);
  Future<void> removeCompetition(String competitionId);
  Future<List<CompetitionRead>> getCurrentUserCompetitions();
}
