import 'package:climbing_app/arch/single_result_bloc/single_result_bloc.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_event.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_single_result.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserBloc
    extends SingleResultBloc<UserEvent, UserState, UserSingleResult> {
  final UserRepository repository;

  UserBloc(this.repository) : super(const UserState.initial()) {
    on<UserEventLogin>((event, emit) async {
      emit(const UserState.loading());

      (await repository.login(event.usernameOrEmail, event.password)).fold(
        (failure) => failure.fold(
          (failure) => failure.maybeWhen(
            connectionFailure: () =>
                addSingleResult(const UserSingleResult.connectionFailure()),
            orElse: () =>
                addSingleResult(const UserSingleResult.unknownFailure()),
          ),
          (loginFailure) => loginFailure.when(
            badCredentials: () =>
                addSingleResult(const UserSingleResult.badCredentialsFailure()),
            userNotVerified: () => addSingleResult(
              const UserSingleResult.userNotVerifiedFailure(),
            ),
            validationError: (text) =>
                addSingleResult(UserSingleResult.validationFailure(text)),
          ),
        ),
        (user) => addSingleResult(const UserSingleResult.loginSucceed()),
      );

      emit(const UserState.initial());
    });
  }
}
