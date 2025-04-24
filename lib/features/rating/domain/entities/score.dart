import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_participant_read.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score.freezed.dart';
part 'score.g.dart';

@freezed
sealed class Score with _$Score {
  const factory Score({
    required double ascentsScore,
    required double score,
    required int place,
    required User user,
    required List<AscentRead> ascents,
    required List<CompetitionParticipantRead> participations,
  }) = _;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}
