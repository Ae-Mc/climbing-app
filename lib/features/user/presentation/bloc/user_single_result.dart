import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/sign_in_failure.dart';
import 'package:climbing_app/features/user/domain/entities/register_failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_single_result.freezed.dart';

@freezed
class UserSingleResult with _$UserSingleResult {
  const factory UserSingleResult.failure(Failure failure) =
      UserSingleResultFailure;
  const factory UserSingleResult.signInFailure(SignInFailure signInFailure) =
      _SignInFailure;
  const factory UserSingleResult.signInSucceed() = _SignIn;
  const factory UserSingleResult.signOutSucceed() = _SignOut;
  const factory UserSingleResult.registerFailure(
    RegisterFailure registerFailure,
  ) = _RegisterFailure;
  const factory UserSingleResult.registerSucceed() = _RegisterSucceed;
}
