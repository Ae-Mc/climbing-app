import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_route_state.freezed.dart';

@freezed
sealed class AddRouteState with _$AddRouteState {
  const factory AddRouteState.data({
    String? name,
    String? color,
    DateTime? date,
    Category? category,
    String? description,
    List<XFile>? images,
  }) = AddRouteStateData;

  const factory AddRouteState.loading() = AddRouteStateLoading;
}
