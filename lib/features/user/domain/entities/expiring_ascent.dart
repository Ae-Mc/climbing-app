import 'package:climbing_app/features/add_ascent/domain/entities/ascent.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expiring_ascent.freezed.dart';
part 'expiring_ascent.g.dart';

@Freezed(toJson: false)
class ExpiringAscent with _$ExpiringAscent {
  const factory ExpiringAscent({
    required Ascent ascent,
    @JsonKey(fromJson: durationFromJson) required Duration timeToExpire,
  }) = _;

  factory ExpiringAscent.fromJson(Map<String, dynamic> json) =>
      _$ExpiringAscentFromJson(json);
}

Duration durationFromJson(double json) =>
    Duration(milliseconds: (json * 1000).round());
