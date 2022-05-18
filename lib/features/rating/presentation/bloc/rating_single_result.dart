part of 'rating_bloc.dart';

@freezed
class RatingSingleResult with _$RatingSingleResult {
  const factory RatingSingleResult.failure(Failure failure) = _Failure;
}
