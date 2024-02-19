import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/update_route/domain/entities/route_update.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateRouteRepository {
  Future<Either<Failure, void>> updateRoute(String routeId, RouteUpdate route);
}
