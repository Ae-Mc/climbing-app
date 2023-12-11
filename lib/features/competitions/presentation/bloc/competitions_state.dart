part of 'competitions_bloc.dart';

@freezed
class CompetitionsState with _$CompetitionsState {
  const factory CompetitionsState.loaded() = _Loaded;
  const factory CompetitionsState.loading() = _Loading;
}
