part of 'competitions_bloc.dart';

@freezed
sealed class CompetitionsSingleResult with _$CompetitionsSingleResult {
  const factory CompetitionsSingleResult.failure(Failure failure) =
      CompetitionsSingleResultFailure;
  const factory CompetitionsSingleResult.success() =
      CompetitionsSingleResultSuccess;
}
