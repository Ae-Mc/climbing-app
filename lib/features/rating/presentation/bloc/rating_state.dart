part of 'rating_bloc.dart';

@freezed
class RatingState with _$RatingState {
  const factory RatingState.loaded(
      List<Score> scores, bool mustBeStudent, bool mustBeFemale) = _Loaded;
  const factory RatingState.loading(bool mustBeStudent, bool mustBeFemale) =
      _Loading;
}
