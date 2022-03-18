import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_single_result.freezed.dart';

@freezed
class UserSingleResult with _$UserSingleResult {
  const factory UserSingleResult.badCredentialsFailure() = _;
  const factory UserSingleResult.connectionFailure() = __;
  const factory UserSingleResult.loginSucceed() = ___;
  const factory UserSingleResult.userNotVerifiedFailure() = ____;
  const factory UserSingleResult.unknownFailure() = _____;
  const factory UserSingleResult.validationFailure(String text) = ______;
}
