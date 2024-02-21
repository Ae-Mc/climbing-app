import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/update_route/data/datasources/update_route_remote_datasource.dart';
import 'package:climbing_app/features/update_route/domain/entities/route_update.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/update_route/domain/repositories/update_route_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UpdateRouteRepository)
class UpdateRouteRepositoryImpl implements UpdateRouteRepository {
  final UpdateRouteRemoteDatasource remoteDatasource;

  UpdateRouteRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, Route>> updateRoute(
      String routeId, RouteUpdate route) async {
    try {
      return Right(await remoteDatasource.updateRoute(routeId, route));
    } on DioException catch (error) {
      return Left(handleDioException(error).fold((l) => l, (r) {
        final message = error.response?.data?.toString() ?? error.message;
        return Failure.unknownFailure(error.copyWith(message: message));
      }));
    }
  }
}
