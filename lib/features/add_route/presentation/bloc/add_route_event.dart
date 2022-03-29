import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_route_event.freezed.dart';

@freezed
class AddRouteEvent with _$AddRouteEvent {
  const factory AddRouteEvent.started() = _Started;
}
