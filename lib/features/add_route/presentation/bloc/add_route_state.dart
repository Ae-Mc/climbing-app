import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_route_state.freezed.dart';

@freezed
class AddRouteState with _$AddRouteState {
  const factory AddRouteState.data({
    String? name,
    String? color,
    DateTime? date,
    User? author,
    Category? category,
    String? description,
    List<XFile>? images,
  }) = AddRouteStateData;

  const factory AddRouteState.loading() = AddRouteStateLoading;
}
