import 'package:itmo_climbing/models/lap.dart';
import 'package:json_annotation/json_annotation.dart';

part 'db_record.g.dart';

@JsonSerializable()
class DBRecord {
  int id;
  Lap firstLap;
  Lap secondLap;
  Lap thirdLap;
  DateTime date;

  DBRecord({
    required this.id,
    required this.date,
    required this.firstLap,
    required this.secondLap,
    required this.thirdLap,
  });

  factory DBRecord.fromJson(Map<String, dynamic> json) =>
      _$DBRecordFromJson(json);

  Map<String, dynamic> toJson() => _$DBRecordToJson(this);

  @override
  String toString() {
    return '$id: ${date.toString()} (${firstLap.toString()}';
  }

  @JsonKey(ignore: true)
  Duration get totalTime => thirdLap.finishTime;
}
