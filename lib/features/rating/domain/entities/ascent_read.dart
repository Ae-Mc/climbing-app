import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ascent_read.freezed.dart';
part 'ascent_read.g.dart';

@freezed
class AscentRead with _$AscentRead {
  const factory AscentRead({
    required String id,
    required bool isFlash,
    required DateTime date,
    required Route route,
  }) = _;
  factory AscentRead.fromJson(Map<String, dynamic> json) =>
      _$AscentReadFromJson(json);
}
