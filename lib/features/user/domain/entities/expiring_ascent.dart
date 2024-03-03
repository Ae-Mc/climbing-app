import 'package:climbing_app/core/entities/ascent.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expiring_ascent.freezed.dart';
part 'expiring_ascent.g.dart';

@Freezed(toJson: false)
class ExpiringAscent with _$ExpiringAscent {
  const factory ExpiringAscent({
    required Ascent ascent,
    @JsonKey(fromJson: durationFromIsoString) required Duration timeToExpire,
  }) = _;

  factory ExpiringAscent.fromJson(Map<String, dynamic> json) =>
      _$ExpiringAscentFromJson(json);
}

Duration durationFromIsoString(String isoString) {
  if (!RegExp(
          r"^(-|\+)?P(?:([-+]?[0-9,.]*)Y)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)W)?(?:([-+]?[0-9,.]*)D)?(?:T(?:([-+]?[0-9,.]*)H)?(?:([-+]?[0-9,.]*)M)?(?:([-+]?[0-9,.]*)S)?)?$")
      .hasMatch(isoString)) {
    throw ArgumentError("String does not follow correct format");
  }

  final weeks = _parseTime(isoString, "W");
  final days = _parseTime(isoString, "D");
  final hours = _parseTime(isoString, "H");
  final minutes = _parseTime(isoString, "M");
  final seconds = _parseTime(isoString, "S");

  return Duration(
    days: days + (weeks * 7),
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );
}

/// Private helper method for extracting a time value from the ISO8601 string.
int _parseTime(String duration, String timeUnit) {
  final timeMatch = RegExp(r"\d+" + timeUnit).firstMatch(duration);

  if (timeMatch == null) {
    return 0;
  }
  final timeString = timeMatch.group(0);
  if (timeString == null) {
    throw IndexError.withLength(0, timeMatch.groupCount);
  }
  return int.parse(timeString.substring(0, timeString.length - 1));
}
