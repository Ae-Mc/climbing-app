import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_failure.freezed.dart';

@freezed
sealed class SignInFailure with _$SignInFailure {
  const factory SignInFailure.badCredentials() = SignInFailureBadCredentials;
  const factory SignInFailure.validationError(String text) =
      SignInFailureValidationError;
  const factory SignInFailure.userNotVerified() = SignInFailureUserNotVerified;
}
