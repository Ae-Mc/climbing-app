import 'package:climbing_app/core/util/handle_dio_connection_error.dart';
import 'package:climbing_app/features/add_route/data/datasources/add_route_remote_datasource.dart';
import 'package:climbing_app/features/add_route/domain/entities/route_create.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_route/domain/repositories/add_route_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AddRouteRepository)
class AddRouteRepositoryImpl implements AddRouteRepository {
  final AddRouteRemoteDatasource remoteDatasource;

  AddRouteRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, void>> addRoute(RouteCreate route) async {
    try {
      // ignore: avoid-ignoring-return-values
      await remoteDatasource.addRoute(route);

      return const Right(null);
    } on DioError catch (error) {
      return Left(handleDioConnectionError(error).fold((l) => l, (r) {
        return Failure.unknownFailure(error);
      }));
    }
  }
}
