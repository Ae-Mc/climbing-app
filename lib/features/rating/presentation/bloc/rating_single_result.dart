part of 'rating_bloc.dart';

@freezed
sealed class RatingSingleResult with _$RatingSingleResult {
  const factory RatingSingleResult.failure(Failure failure) =
      RatingSingleResultFailure;
}
