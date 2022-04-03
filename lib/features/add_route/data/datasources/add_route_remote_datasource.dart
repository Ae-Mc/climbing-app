import 'package:climbing_app/features/add_route/domain/entities/route_create.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';

abstract class AddRouteRemoteDatasource {
  Future<Route> addRoute(RouteCreate route);
}
