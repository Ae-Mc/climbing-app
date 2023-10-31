part of 'rating_bloc.dart';

@freezed
class RatingState with _$RatingState {
  const factory RatingState.loaded(List<Score> scores, bool mustBeStudent) =
      _Loaded;
  const factory RatingState.loading(bool mustBeStudent) = _Loading;
}
