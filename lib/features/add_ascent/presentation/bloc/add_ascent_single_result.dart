part of 'add_ascent_bloc.dart';

@freezed
class AddAscentSingleResult with _$AddAscentSingleResult {
  const factory AddAscentSingleResult.failure(Failure failure) = _Failure;
  const factory AddAscentSingleResult.success() = _Success;
}
