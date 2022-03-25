import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_failure.freezed.dart';

@freezed
class SignUpFailure with _$SignUpFailure {
  const factory SignUpFailure.validationError(String text) =
      SignUpFailureValidationError;
  const factory SignUpFailure.userAlreadyExists() =
      SignUpFailureUserAlreadyExists;
  const factory SignUpFailure.invalidPassword(String reason) =
      SignUpFailureInvalidPassword;
}
