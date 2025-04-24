part of 'user_bloc.dart';

@freezed
sealed class UserSingleResult with _$UserSingleResult {
  const factory UserSingleResult.failure(Failure failure) =
      UserSingleResultFailure;
  const factory UserSingleResult.passwordResetFailure(
    PasswordResetFailure failure,
  ) = UserSingleResultPasswordResetFailure;
  const factory UserSingleResult.signInFailure(SignInFailure signInFailure) =
      UserSingleResultSignInFailure;
  const factory UserSingleResult.signInSucceed() = UserSingleResultSignIn;
  const factory UserSingleResult.signOutSucceed() = UserSingleResultSignOut;
  const factory UserSingleResult.registerFailure(
    RegisterFailure registerFailure,
  ) = UserSingleResultRegisterFailure;
  const factory UserSingleResult.registerSucceed() =
      UserSingleResultRegisterSucceed;
  const factory UserSingleResult.success() = UserSingleResultSuccess;
}
