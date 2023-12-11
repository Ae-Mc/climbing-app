part of 'competitions_bloc.dart';

@freezed
class CompetitionsSingleResult with _$CompetitionsSingleResult {
  const factory CompetitionsSingleResult.failure(Failure failure) = _Failure;
  const factory CompetitionsSingleResult.success() = _Success;
}
