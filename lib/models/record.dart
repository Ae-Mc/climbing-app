import 'package:traverse/models/lap.dart';
import 'package:json_annotation/json_annotation.dart';
part 'record.g.dart';

@JsonSerializable(createFactory: false)
class Record {
  Lap? firstLap;
  Lap? secondLap;
  Lap? thirdLap;
  DateTime date;

  Record({
    DateTime? date,
    this.firstLap,
    this.secondLap,
    this.thirdLap,
  }) : date = date ?? DateTime.now();

  String toString() {
    return date.toString() + ' ' + firstLap.toString();
  }

  Map<String, dynamic> toJson() => _$RecordToJson(this);

  @JsonKey(ignore: true)
  Duration? get totalTime => thirdLap?.finishTime;

  @JsonKey(ignore: true)
  bool get isEmpty => firstLap == null && secondLap == null && thirdLap == null;
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;
  @JsonKey(ignore: true)
  bool get isFilled =>
      firstLap != null && secondLap != null && thirdLap != null;

  void clear() {
    firstLap = null;
    secondLap = null;
    thirdLap = null;
  }
}
