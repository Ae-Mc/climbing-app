import 'package:freezed_annotation/freezed_annotation.dart';
part 'routes_bloc_event.freezed.dart';

@freezed
class RoutesBlocEvent with _$RoutesBlocEvent {
  const factory RoutesBlocEvent.loadRoutes() = RoutesBlocEventLoadRoutes;
}
