part of 'competitions_bloc.dart';

@freezed
class CompetitionsEvent with _$CompetitionsEvent {
  const factory CompetitionsEvent.addCompetition(
    CompetitionCreate competition,
  ) = _AddCompetition;
  const factory CompetitionsEvent.removeCompetition(String competitionId) =
      _RemoveCompetition;
}
