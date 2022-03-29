import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_route_state.freezed.dart';

@freezed
class AddRouteState with _$AddRouteState {
  const factory AddRouteState.initial() = _Initial;
}
