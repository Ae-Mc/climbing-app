import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/features/routes/data/datasources/routes_remote_datasource.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/repositories/routes_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: RoutesRepository)
class RoutesRepositoryImpl implements RoutesRepository {
  final RoutesRemoteDatasource remoteDatasource;

  const RoutesRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<Route>>> getAllRoutes(bool? archived) {
    return remoteDatasource.allRoutes(archived);
  }

  @override
  Future<Either<Failure, void>> removeRoute(Route route) {
    return remoteDatasource.removeRoute(route.id);
  }

  @override
  Future<Either<Failure, List<Ascent>>> routeAscents(Route route) {
    return remoteDatasource.routeAscents(route.id);
  }
}
