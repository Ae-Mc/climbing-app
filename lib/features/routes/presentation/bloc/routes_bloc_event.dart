part of 'routes_bloc.dart';

@freezed
sealed class RoutesBlocEvent with _$RoutesBlocEvent {
  const factory RoutesBlocEvent.loadRoutes([@Default(false) bool? archived]) =
      RoutesBlocEventLoadRoutes;
  const factory RoutesBlocEvent.removeRoute(Route route) =
      RoutesBlocEventRemoveRoute;
}
