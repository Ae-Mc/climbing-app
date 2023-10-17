import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'competition_participant_read.freezed.dart';
part 'competition_participant_read.g.dart';

@freezed
class CompetitionParticipantRead with _$CompetitionParticipantRead {
  const factory CompetitionParticipantRead({
    required String id,
    required int place,
    required CompetitionRead competition,
  }) = _;

  factory CompetitionParticipantRead.fromJson(Map<String, dynamic> json) =>
      CompetitionParticipantRead.fromJson(json);
}
