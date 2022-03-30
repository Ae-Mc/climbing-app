import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_route/domain/entities/route_create.dart';
import 'package:dartz/dartz.dart';

abstract class AddRouteRepository {
  Future<Either<Failure, void>> addRoute(RouteCreate route);
}
