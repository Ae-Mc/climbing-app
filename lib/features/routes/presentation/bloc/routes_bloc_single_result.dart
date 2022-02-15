import 'package:climbing_app/core/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'routes_bloc_single_result.freezed.dart';

@freezed
class RoutesBlocSingleResult with _$RoutesBlocSingleResult {
  const factory RoutesBlocSingleResult.connectionFailure() =
      RoutesBlocSingleResultConnectionFailure;
  const factory RoutesBlocSingleResult.serverFailure(
    ServerFailure serverFailure,
  ) = RoutesBlocSingleResultServerFailure;
  const factory RoutesBlocSingleResult.unknownFailure() =
      RoutesBlocSingleResultUnknownFailure;
}
