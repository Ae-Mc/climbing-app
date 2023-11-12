part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.fetch() = UserEventFetch;
  const factory UserEvent.initialize() = UserEventInit;
  const factory UserEvent.signIn(String usernameOrEmail, String password) =
      UserEventSignIn;
  const factory UserEvent.signOut() = UserEventSignOut;
  const factory UserEvent.register(UserCreate userCreate) = UserEventRegister;
  const factory UserEvent.forgotPassword(String email) =
      UserEventForgotPassword;
  const factory UserEvent.resetPassword(String token, String password) =
      UserEventResetPassword;
}
