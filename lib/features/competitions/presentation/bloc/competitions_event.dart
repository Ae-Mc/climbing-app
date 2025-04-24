part of 'competitions_bloc.dart';

@freezed
sealed class CompetitionsEvent with _$CompetitionsEvent {
  const factory CompetitionsEvent.addCompetition(
    CompetitionCreate competition,
  ) = CompetitionsEventAddCompetition;
  const factory CompetitionsEvent.removeCompetition(String competitionId) =
      CompetitionsEventRemoveCompetition;
}
