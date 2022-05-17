import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ascent.freezed.dart';
part 'ascent.g.dart';

@freezed
class Ascent with _$Ascent {
  const factory Ascent({
    required String id,
    required DateTime date,
    required bool isFlash,
    required Route route,
    required User user,
  }) = _;

  factory Ascent.fromJson(Map<String, dynamic> json) => _$AscentFromJson(json);
}
