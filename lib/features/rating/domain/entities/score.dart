import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score.freezed.dart';
part 'score.g.dart';

@freezed
class Score with _$Score {
  const factory Score({
    required double ascentsScore,
    required double score,
    required User user,
  }) = _;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}
