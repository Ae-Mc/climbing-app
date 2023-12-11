import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/competitions/domain/entities/competition_create.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';
import 'package:dartz/dartz.dart';

abstract class CompetitionsRepository {
  Future<Either<Failure, void>> addCompetition(CompetitionCreate competition);
  Future<Either<Failure, void>> removeCompetition(String competitionId);
  Future<Either<Failure, List<CompetitionRead>>> getCurrentUserCompetitions();
}
