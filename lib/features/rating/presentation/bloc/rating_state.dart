part of 'rating_bloc.dart';

@freezed
sealed class RatingState with _$RatingState {
  const factory RatingState.loaded(
          List<Score> scores, bool mustBeStudent, bool mustBeFemale) =
      RatingStateLoaded;
  const factory RatingState.loading(bool mustBeStudent, bool mustBeFemale) =
      RatingStateLoading;
}
