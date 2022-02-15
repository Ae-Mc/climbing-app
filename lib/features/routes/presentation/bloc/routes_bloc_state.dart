import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'routes_bloc_state.freezed.dart';

@freezed
class RoutesBlocState with _$RoutesBlocState {
  const factory RoutesBlocState.connectionFailure() =
      RoutesBlocStateConnectionFailure;
  const factory RoutesBlocState.loaded(List<Route> routes) =
      RoutesBlocStateLoaded;
  const factory RoutesBlocState.loading() = RoutesBlocStateLoading;
  const factory RoutesBlocState.serverFailure(ServerFailure serverFailure) =
      RoutesBlocStateServerFailure;
  const factory RoutesBlocState.unknownFailure() =
      RoutesBlocStateUnknownFailure;
}
