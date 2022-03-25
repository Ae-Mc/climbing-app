import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.freezed.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.initialize() = UserEventInit;
  const factory UserEvent.login(String usernameOrEmail, String password) =
      UserEventLogin;
  const factory UserEvent.logout() = UserEventLogout;
  const factory UserEvent.register(UserCreate userCreate) = UserEventRegister;
}
