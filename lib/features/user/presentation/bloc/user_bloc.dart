import 'package:climbing_app/arch/single_result_bloc/single_result_bloc.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_event.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_single_result.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

typedef UserEmitter = Emitter<UserState>;

@injectable
class UserBloc
    extends SingleResultBloc<UserEvent, UserState, UserSingleResult> {
  final UserRepository repository;

  UserBloc(this.repository) : super(const UserState.notAuthorized()) {
    on<UserEvent>(handleEvent);
  }

  Future<void> handleEvent(UserEvent event, UserEmitter emit) async {
    await event.map<Future<void>>(
      login: (event) => login(event, emit),
      logout: (_) => logout(emit),
    );
  }

  Future<void> login(UserEventLogin event, UserEmitter emit) async {
    emit(const UserState.loading());

    await (await repository.login(event.usernameOrEmail, event.password))
        .fold<Future<void>>(
      (failure) async {
        emit(const UserState.notAuthorized());
        failure.fold(
          (failure) => addSingleResult(UserSingleResult.failure(failure)),
          (loginFailure) => UserSingleResult.loginFailure(loginFailure),
        );
      },
      (_) async {
        final currentUser = await repository.getCurrentUser();
        currentUser.fold(
          (l) => emit(const UserState.notAuthorized()),
          (r) {
            emit(UserState.authorized(r));
            addSingleResult(const UserSingleResult.loginSucceed());
          },
        );
      },
    );
  }

  Future<void> logout(UserEmitter emit) async {
    final previousState = state.when<UserState>(
      loading: () => const UserState.loading(),
      authorized: (user) => UserState.authorized(user),
      notAuthorized: () => const UserState.notAuthorized(),
    );
    emit(const UserState.loading());
    (await repository.logout()).fold<void>(
      (failure) {
        addSingleResult(UserSingleResult.failure(failure));
        emit(previousState);
      },
      (_) {
        addSingleResult(const UserSingleResult.logoutSucceed());
        emit(const UserState.notAuthorized());
      },
    );
  }
}
