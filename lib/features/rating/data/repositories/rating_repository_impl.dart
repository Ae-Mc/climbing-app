import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/rating/data/datasources/rating_remote_datasource.dart';
import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/rating/domain/repositories/rating_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RatingRepository)
class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDatasource remoteDatasource;

  RatingRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<Score>>> getRating(
      bool mustBeStudent, bool mustBeFemale) async {
    try {
      return Right(
          await remoteDatasource.getRating(mustBeStudent, mustBeFemale));
    } on DioException catch (error) {
      return Left(handleDioException(error)
          .fold((l) => l, (r) => Failure.unknownFailure(error)));
    }
  }

  @override
  Future<List<AscentRead>> getUserRatingAscents(String userId) =>
      remoteDatasource.getUserRatingAscents(userId);
}
