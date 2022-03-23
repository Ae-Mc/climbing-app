import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/login_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_single_result.freezed.dart';

@freezed
class UserSingleResult with _$UserSingleResult {
  const factory UserSingleResult.loginSucceed() = _Login;
  const factory UserSingleResult.logoutSucceed() = _Logout;
  const factory UserSingleResult.loginFailure(LoginFailure loginFailure) =
      _LoginFailure;
  const factory UserSingleResult.failure(Failure failure) =
      UserSingleResultFailure;
}
