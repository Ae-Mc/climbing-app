import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.authorized(User user) = UserStateAuthorized;
  const factory UserState.initializationFailure(Failure failure) =
      UserStateInitializationFailure;
  const factory UserState.loading() = UserStateLoading;
  const factory UserState.notAuthorized() = UserStateNotAuthorized;
}
