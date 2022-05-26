part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.authorized({
    required User activeUser,
    required List<User> allUsers,
    required List<Route> userRoutes,
  }) = UserStateAuthorized;
  const factory UserState.initializationFailure(Failure failure) =
      UserStateInitializationFailure;
  const factory UserState.loading() = UserStateLoading;
  const factory UserState.notAuthorized() = UserStateNotAuthorized;
}
