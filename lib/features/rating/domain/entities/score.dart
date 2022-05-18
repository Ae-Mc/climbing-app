import 'package:climbing_app/features/add_ascent/domain/entities/ascent.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'score.freezed.dart';
part 'score.g.dart';

@freezed
class Score with _$Score {
  const factory Score({
    required List<Ascent> ascents,
    required User user,
    required double score,
  }) = _;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}
