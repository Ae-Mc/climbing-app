import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_competition/domain/entities/competition_create.dart';
import 'package:dartz/dartz.dart';

abstract class AddCompetitionRepository {
  Future<Either<Failure, void>> addCompetition(CompetitionCreate competition);
}
