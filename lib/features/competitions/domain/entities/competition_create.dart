import 'package:climbing_app/features/competitions/domain/entities/participant_create.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'competition_create.freezed.dart';
part 'competition_create.g.dart';

@freezed
sealed class CompetitionCreate with _$CompetitionCreate {
  const factory CompetitionCreate({
    required String name,
    @JsonKey(toJson: dateTimeToDate, fromJson: dateToDateTime)
    required DateTime date,
    required double ratio,
    required List<ParticipantCreate> participants,
  }) = _;

  factory CompetitionCreate.fromJson(Map<String, dynamic> json) =>
      _$CompetitionCreateFromJson(json);
}

String dateTimeToDate(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

DateTime dateToDateTime(String date) {
  return DateFormat('yyyy-MM-dd').parse(date);
}
