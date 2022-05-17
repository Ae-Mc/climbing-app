import 'package:freezed_annotation/freezed_annotation.dart';

part 'ascent_create.freezed.dart';
part 'ascent_create.g.dart';

@freezed
class AscentCreate with _$AscentCreate {
  const factory AscentCreate({
    required String routeId,
    required DateTime date,
    required bool isFlash,
  }) = _;

  factory AscentCreate.fromJson(Map<String, dynamic> json) =>
      _$AscentCreateFromJson(json);
}
