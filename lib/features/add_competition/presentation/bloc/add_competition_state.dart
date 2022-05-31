part of 'add_competition_bloc.dart';

@freezed
class AddCompetitionState with _$AddCompetitionState {
	const factory AddCompetitionState.loaded() = _Loaded;
	const factory AddCompetitionState.loading() = _Loading;
}