import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/competitions/data/datasources/competitions_datasource.dart';
import 'package:climbing_app/features/competitions/domain/entities/competition_create.dart';
import 'package:climbing_app/features/competitions/domain/repositories/competitions_repository.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CompetitionsRepository)
class CompetitionsRepositoryImpl implements CompetitionsRepository {
  final CompetitionsDatasource datasource;

  CompetitionsRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<CompetitionRead>>>
      getCurrentUserCompetitions() async {
    try {
      return Right(await datasource.getCurrentUserCompetitions());
    } on DioException catch (error) {
      return Left(handleDioException(error).fold(
        (l) => l,
        (r) => const UnknownFailure(),
      ));
    }
  }

  @override
  Future<Either<Failure, void>> addCompetition(
    CompetitionCreate competition,
  ) async {
    try {
      return Right(await datasource.addCompetition(competition));
    } on DioException catch (error) {
      return Left(handleDioException(error)
          .fold((l) => l, (r) => Failure.unknownFailure(r)));
    }
  }

  @override
  Future<Either<Failure, void>> removeCompetition(String competitionId) async {
    try {
      return Right(await datasource.removeCompetition(competitionId));
    } on DioException catch (error) {
      return Left(handleDioException(error)
          .fold((l) => l, (r) => Failure.unknownFailure(r)));
    }
  }
}
