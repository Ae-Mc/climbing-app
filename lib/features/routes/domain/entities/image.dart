import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
class Image with _$Image {
  @JsonSerializable()
  factory Image({
    required String id,
    required String url,
    required String createdAt,
  }) = _;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
