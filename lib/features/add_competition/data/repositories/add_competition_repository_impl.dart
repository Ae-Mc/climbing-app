import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/add_competition/data/datasources/add_competition_remote_datasource.dart';
import 'package:climbing_app/features/add_competition/domain/entities/competition_create.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_competition/domain/repositories/add_competition_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

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
    } on DioException catch (error) {
      return Left(handleDioException(error).fold((l) => l, (r) {
        GetIt.I<Logger>().e(r.response?.data, error: r);
        GetIt.I<Logger>().d(r.requestOptions.data);

        return Failure.unknownFailure(r);
      }));
    }
  }
}
