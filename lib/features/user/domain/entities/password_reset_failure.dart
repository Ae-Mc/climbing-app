import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_reset_failure.freezed.dart';

@freezed
sealed class PasswordResetFailure with _$PasswordResetFailure {
  const factory PasswordResetFailure.badPassword() =
      PasswordResetFailureBadPassword;
  const factory PasswordResetFailure.validationError(String text) =
      PasswordResetFailureValidationError;
  const factory PasswordResetFailure.wrongToken() =
      PasswordResetFailureWrongToken;
}
