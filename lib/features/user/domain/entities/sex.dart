import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Sex {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female
}
