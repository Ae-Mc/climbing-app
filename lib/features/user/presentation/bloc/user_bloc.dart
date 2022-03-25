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
      initialize: (_) => initialize(emit),
      signOut: (_) => signOut(emit),
      signIn: (event) => signIn(event, emit),
      register: (event) => register(event, emit),
    );
  }

  Future<void> initialize(UserEmitter emit) async {
    emit(const UserState.loading());
    if (repository.isAuthenticated) {
      (await repository.getCurrentUser()).fold(
        (failure) {
          if (repository.isAuthenticated) {
            emit(UserState.initializationFailure(failure));
            addSingleResult(UserSingleResult.failure(failure));
          } else {
            emit(const UserState.notAuthorized());
          }
        },
        (user) {
          emit(UserState.authorized(user));
          addSingleResult(const UserSingleResult.signInSucceed());
        },
      );
    } else {
      emit(const UserState.notAuthorized());
    }
  }

  Future<void> signIn(UserEventSignIn event, UserEmitter emit) async {
    emit(const UserState.loading());

    await (await repository.signIn(event.usernameOrEmail, event.password))
        .fold<Future<void>>(
      (failure) async {
        emit(const UserState.notAuthorized());
        addSingleResult(failure.fold(
          (failure) => UserSingleResult.failure(failure),
          (signInFailure) => UserSingleResult.signInFailure(signInFailure),
        ));
      },
      (_) async {
        final currentUser = await repository.getCurrentUser();
        currentUser.fold(
          (l) => emit(const UserState.notAuthorized()),
          (r) {
            emit(UserState.authorized(r));
            addSingleResult(const UserSingleResult.signInSucceed());
          },
        );
      },
    );
  }

  Future<void> signOut(UserEmitter emit) async {
    final previousState = state.when<UserState>(
      authorized: (user) => UserState.authorized(user),
      initializationFailure: (failure) =>
          UserState.initializationFailure(failure),
      loading: () => const UserState.loading(),
      notAuthorized: () => const UserState.notAuthorized(),
    );
    emit(const UserState.loading());
    (await repository.signOut()).fold<void>(
      (failure) {
        addSingleResult(UserSingleResult.failure(failure));
        emit(previousState);
      },
      (_) {
        addSingleResult(const UserSingleResult.signOutSucceed());
        emit(const UserState.notAuthorized());
      },
    );
  }

  Future<void> register(UserEventRegister event, UserEmitter emit) async {
    emit(const UserState.loading());
    addSingleResult(
      (await repository.register(event.userCreate)).fold<UserSingleResult>(
        (failure) => failure.fold(
          (l) => UserSingleResult.failure(l),
          (r) => UserSingleResult.registerFailure(r),
        ),
        (r) => const UserSingleResult.registerSucceed(),
      ),
    );
    emit(const UserState.notAuthorized());
  }
}
