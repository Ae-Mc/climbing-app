part of 'add_ascent_bloc.dart';

@freezed
sealed class AddAscentSingleResult with _$AddAscentSingleResult {
  const factory AddAscentSingleResult.failure(Failure failure) =
      AddAscentSingleResultFailure;
  const factory AddAscentSingleResult.success() = AddAscentSingleResultSuccess;
}
