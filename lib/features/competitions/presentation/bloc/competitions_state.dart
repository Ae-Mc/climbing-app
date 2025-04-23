part of 'competitions_bloc.dart';

@freezed
sealed class CompetitionsState with _$CompetitionsState {
  const factory CompetitionsState.loaded() = CompetitionsStateLoaded;
  const factory CompetitionsState.loading() = CompetitionsStateLoading;
}
