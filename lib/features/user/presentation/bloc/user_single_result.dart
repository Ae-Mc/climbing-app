part of 'user_bloc.dart';

@freezed
class UserSingleResult with _$UserSingleResult {
  const factory UserSingleResult.failure(Failure failure) =
      UserSingleResultFailure;
  const factory UserSingleResult.passwordResetFailure(
    PasswordResetFailure failure,
  ) = _PasswordResetFailure;
  const factory UserSingleResult.signInFailure(SignInFailure signInFailure) =
      _SignInFailure;
  const factory UserSingleResult.signInSucceed() = _SignIn;
  const factory UserSingleResult.signOutSucceed() = _SignOut;
  const factory UserSingleResult.registerFailure(
    RegisterFailure registerFailure,
  ) = _RegisterFailure;
  const factory UserSingleResult.registerSucceed() = _RegisterSucceed;
  const factory UserSingleResult.success() = UserSingleResultSuccess;
}
