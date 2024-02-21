import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/features/update_route/domain/entities/file.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_update.g.dart';

@JsonSerializable(createFactory: false)
class RouteUpdate {
  final String name;
  final Category category;
  final String markColor;
  final String description;
  final String creationDate;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final List<File> images;
  final bool archived;

  const RouteUpdate({
    required this.category,
    required this.creationDate,
    required this.description,
    required this.images,
    required this.markColor,
    required this.name,
    required this.archived,
  });

  Map<String, dynamic> toJson() => _$RouteUpdateToJson(this);
}
