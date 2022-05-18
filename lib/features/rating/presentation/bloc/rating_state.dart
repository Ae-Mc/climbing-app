part of 'rating_bloc.dart';

@freezed
class RatingState with _$RatingState {
  const factory RatingState.loaded(List<Score> scores) = _Loaded;
  const factory RatingState.loading() = _Loading;
}
