import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ascent_read.freezed.dart';
part 'ascent_read.g.dart';

@Freezed(copyWith: false)
@JsonSerializable()
class AscentRead with _$AscentRead {
  @override
  final String id;
  @override
  final bool isFlash;
  @override
  final DateTime date;
  @override
  final Route route;

  const AscentRead({
    required this.id,
    required this.isFlash,
    required this.date,
    required this.route,
  });

  factory AscentRead.fromJson(Map<String, dynamic> json) =>
      _$AscentReadFromJson(json);

  Map<String, dynamic> toJson() => _$AscentReadToJson(this);
}
