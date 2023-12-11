import 'package:freezed_annotation/freezed_annotation.dart';

part 'participant_create.freezed.dart';
part 'participant_create.g.dart';

@freezed
class ParticipantCreate with _$ParticipantCreate {
  const factory ParticipantCreate({
    required int place,
    required String userId,
  }) = _;

  factory ParticipantCreate.fromJson(Map<String, dynamic> json) =>
      _$ParticipantCreateFromJson(json);
}
