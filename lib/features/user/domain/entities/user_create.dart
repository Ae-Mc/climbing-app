import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_create.freezed.dart';
part 'user_create.g.dart';

@freezed
class UserCreate with _$UserCreate {
  const factory UserCreate({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String username,
    required bool isStudent,
  }) = _UserCreate;

  factory UserCreate.fromJson(Map<String, dynamic> json) =>
      _$UserCreateFromJson(json);
}
