part of 'routes_bloc.dart';

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
