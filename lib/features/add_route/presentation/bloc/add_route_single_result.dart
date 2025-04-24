import 'package:climbing_app/core/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_route_single_result.freezed.dart';

@freezed
sealed class AddRouteSingleResult with _$AddRouteSingleResult {
  const factory AddRouteSingleResult.addedSuccessfully() =
      AddRouteSingleResultAddedSuccessfully;
  const factory AddRouteSingleResult.failure(Failure failure) =
      AddRouteSingleResultFailure;
  // const factory AddRouteSingleResult.addFailure(Failure failure) = AddRouteSingleResultFailure;
}
