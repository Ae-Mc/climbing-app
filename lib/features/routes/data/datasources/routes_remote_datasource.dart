import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:dartz/dartz.dart';

abstract class RoutesRemoteDatasource {
  Future<Either<Failure, List<Route>>> allRoutes(bool? archived);
  Future<Either<Failure, void>> removeRoute(String id);
  Future<Either<Failure, List<Ascent>>> routeAscents(String id);
}
