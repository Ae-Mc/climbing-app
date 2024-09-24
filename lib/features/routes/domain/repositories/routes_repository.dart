import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:dartz/dartz.dart';

abstract class RoutesRepository {
  Future<Either<Failure, List<Route>>> getAllRoutes(bool? archived);
  Future<Either<Failure, void>> removeRoute(Route route);
  Future<Either<Failure, List<Ascent>>> routeAscents(Route route);
}
