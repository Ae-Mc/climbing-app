import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.initialize() = UserEventInit;
  const factory UserEvent.signIn(String usernameOrEmail, String password) =
      UserEventSignIn;
  const factory UserEvent.signOut() = UserEventSignOut;
  const factory UserEvent.register(UserCreate userCreate) = UserEventRegister;
}
