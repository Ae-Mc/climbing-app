import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/update_route/domain/entities/route_update.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateRouteRepository {
  Future<Either<Failure, Route>> updateRoute(String routeId, RouteUpdate route);
}
