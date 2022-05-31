import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/add_competition/data/datasources/add_competition_remote_datasource.dart';
import 'package:climbing_app/features/add_competition/domain/entities/competition_create.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_competition/domain/repositories/add_competition_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AddCompetitionRepository)
class AddCompetitionRepositoryImpl implements AddCompetitionRepository {
  final AddCompetitionRemoteDatasource remoteDatasource;

  AddCompetitionRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, void>> addCompetition(
    CompetitionCreate competition,
  ) async {
    try {
      return Right(await remoteDatasource.addCompetition(competition));
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error)
          .fold((l) => l, (r) => Failure.unknownFailure(r)));
    }
  }
}
