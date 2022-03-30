import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'route_create.g.dart';

@JsonSerializable(createFactory: false)
class RouteCreate {
  final String name;
  final Category category;
  final String markColor;
  final String author;
  final String description;
  final String creationDate;
  @JsonKey(ignore: true)
  final List<XFile> images;

  const RouteCreate({
    required this.author,
    required this.category,
    required this.creationDate,
    required this.description,
    required this.images,
    required this.markColor,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$RouteCreateToJson(this);
}
