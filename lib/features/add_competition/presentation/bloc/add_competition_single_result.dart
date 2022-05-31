part of 'add_competition_bloc.dart';

@freezed
class AddCompetitionSingleResult with _$AddCompetitionSingleResult {
  const factory AddCompetitionSingleResult.failure(Failure failure) = _Failure;
  const factory AddCompetitionSingleResult.success() = _Success;
}
