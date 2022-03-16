import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

@freezed
class LoginFailure with _$LoginFailure {
  const factory LoginFailure.badCredentials() = LoginFailureBadCredentials;
  const factory LoginFailure.validationError(String text) =
      LoginFailureValidationError;
  const factory LoginFailure.userNotVerified() = LoginFailureUserNotVerified;
}
