import 'package:climbing_app/features/update_route/domain/entities/route_update.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';

abstract class UpdateRouteRemoteDatasource {
  Future<Route> updateRoute(String routeId, RouteUpdate route);
}
