part of 'routes_bloc.dart';

@freezed
sealed class RoutesBlocSingleResult with _$RoutesBlocSingleResult {
  const factory RoutesBlocSingleResult.failure(Failure failure) =
      RoutesBlocSingleResultFailure;
  const factory RoutesBlocSingleResult.removeRouteSuccess() =
      RoutesBlocSingleResultRemoveRouteSuccess;
}
