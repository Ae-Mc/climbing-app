import 'package:freezed_annotation/freezed_annotation.dart';

part 'competition_read.freezed.dart';
part 'competition_read.g.dart';

@freezed
sealed class CompetitionRead with _$CompetitionRead {
  const factory CompetitionRead({
    required String id,
    required String name,
    required DateTime date,
    required double ratio,
    required DateTime createdAt,
  }) = _;

  factory CompetitionRead.fromJson(Map<String, dynamic> json) =>
      _$CompetitionReadFromJson(json);
}
