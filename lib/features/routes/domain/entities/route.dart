import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/features/routes/domain/entities/image.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route.freezed.dart';
part 'route.g.dart';

@freezed
sealed class Route with _$Route {
  @JsonSerializable()
  const factory Route({
    required String id,
    required String name,
    required Category category,
    required String markColor,
    required String description,
    required DateTime creationDate,
    required DateTime createdAt,
    required List<Image> images,
    required User author,
    required bool archived,
  }) = _Route;

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);
}
