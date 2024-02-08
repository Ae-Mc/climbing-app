import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/activity_feed/data/datasources/activity_feed_remote_datasource.dart';
import 'package:climbing_app/features/activity_feed/domain/repositories/activity_feed_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ActivityFeedRepository)
class ActivityFeedRepositoryImpl implements ActivityFeedRepository {
  final ActivityFeedRemoteDatasource datasource;

  ActivityFeedRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Ascent>>> recentAscents() async {
    try {
      return Right(await datasource.recentAscents());
    } on DioException catch (e) {
      return Left(handleDioException(e)
          .fold((l) => l, (r) => Failure.unknownFailure(r)));
    }
  }
}
