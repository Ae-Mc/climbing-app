part of 'add_competition_bloc.dart';

@freezed
class AddCompetitionEvent with _$AddCompetitionEvent {
  const factory AddCompetitionEvent.addCompetition(
    CompetitionCreate competition,
  ) = _AddCompetition;
}
