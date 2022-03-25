import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_failure.freezed.dart';

@freezed
class RegisterFailure with _$RegisterFailure {
  const factory RegisterFailure.validationError(String text) =
      RegisterFailureValidationError;
  const factory RegisterFailure.userAlreadyExists() =
      RegisterFailureUserAlreadyExists;
  const factory RegisterFailure.invalidPassword(String reason) =
      RegisterFailureInvalidPassword;
}
