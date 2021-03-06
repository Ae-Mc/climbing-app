import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/rating/data/datasources/rating_remote_datasource.dart';
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
  Future<Either<Failure, List<Score>>> getRating() async {
    try {
      return Right(await remoteDatasource.getRating());
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error)
          .fold((l) => l, (r) => Failure.unknownFailure(error)));
    }
  }
}
