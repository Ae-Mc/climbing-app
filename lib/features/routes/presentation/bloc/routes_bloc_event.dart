part of 'routes_bloc.dart';

@freezed
class RoutesBlocEvent with _$RoutesBlocEvent {
  const factory RoutesBlocEvent.loadRoutes() = RoutesBlocEventLoadRoutes;
  const factory RoutesBlocEvent.removeRoute(Route route) =
      RoutesBlocEventRemoveRoute;
}
