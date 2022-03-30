import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_route_event.freezed.dart';

@freezed
class AddRouteEvent with _$AddRouteEvent {
  const factory AddRouteEvent.uploadRoute() = AddRouteEventUploadRoute;
  const factory AddRouteEvent.setName(String name) = AddRouteEventSetName;
  const factory AddRouteEvent.setMarksColor(String marksColor) =
      AddRouteEventSetMarksColor;
  const factory AddRouteEvent.setDate(DateTime date) = AddRouteEventSetDate;
  const factory AddRouteEvent.setDescription(String description) =
      AddRouteEventSetDescription;
  const factory AddRouteEvent.setAuthor(User author) = AddRouteEventSetAuthor;
  const factory AddRouteEvent.setCategory(Category category) =
      AddRouteEventSetCategory;
  const factory AddRouteEvent.setImages(List<XFile> images) =
      AddRouteEventSetImages;
}
