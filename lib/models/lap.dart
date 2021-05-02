import 'package:json_annotation/json_annotation.dart';

part 'lap.g.dart';

@JsonSerializable()
class Lap {
  final Duration duration;
  final Duration finishTime;

  Lap({
    this.duration = Duration.zero,
    this.finishTime = Duration.zero,
  });

  Map<String, dynamic> toJson() => _$LapToJson(this);
  factory Lap.fromJson(Map<String, dynamic> json) => _$LapFromJson(json);

  @JsonKey(ignore: true)
  @override
  String toString() {
    return duration.toString();
  }
}
