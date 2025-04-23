import 'package:climbing_app/features/user/domain/entities/sex.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
sealed class User with _$User {
  @JsonSerializable()
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    required String username,
    required Sex sex,
    required bool isStudent,
    required bool isSuperuser,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
