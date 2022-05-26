import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/user/domain/entities/register_failure.dart';
import 'package:climbing_app/features/user/domain/entities/sign_in_failure.dart';
import 'package:climbing_app/features/user/domain/entities/user.dart';
import 'package:climbing_app/features/user/domain/entities/user_create.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

part 'user_bloc.freezed.dart';
part 'user_event.dart';
part 'user_single_result.dart';
part 'user_state.dart';

typedef UserEmitter = Emitter<UserState>;

@injectable
class UserBloc
    extends SingleResultBloc<UserEvent, UserState, UserSingleResult> {
  final UserRepository repository;

  UserBloc(this.repository) : super(const UserState.notAuthorized()) {
    on<UserEvent>(handleEvent);
  }

  Future<void> handleEvent(UserEvent event, UserEmitter emit) =>
      event.map<Future<void>>(
        initialize: (_) => initialize(emit),
        signOut: (_) => signOut(emit),
        signIn: (event) => signIn(event, emit),
        register: (event) => register(event, emit),
      );

  Future<void> initialize(UserEmitter emit) async {
    emit(const UserState.loading());
    if (repository.isAuthenticated) {
      await fetchUserData(
        onFailure: (failure) async {
          if (repository.isAuthenticated) {
            emit(UserState.initializationFailure(failure));
            addSingleResult(UserSingleResult.failure(failure));
          } else {
            emit(const UserState.notAuthorized());
          }
        },
        emit: emit,
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
      (_) => fetchUserData(
        onFailure: (failure) async {
          emit(const UserState.notAuthorized());
          addSingleResult(UserSingleResult.failure(failure));
        },
        emit: emit,
      ),
    );
  }

  Future<void> signOut(UserEmitter emit) async {
    final previousState = state.when<UserState>(
      authorized: (user, allUsers) =>
          UserState.authorized(activeUser: user, allUsers: allUsers),
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

  Future<void> fetchUserData({
    required Future<void> Function(Failure failure) onFailure,
    required UserEmitter emit,
  }) async {
    await (await repository.getCurrentUser()).fold<Future<void>>(
      onFailure,
      (activeUser) async {
        await (await repository.getAllUsers()).fold<Future<void>>(
          onFailure,
          (allUsers) async {
            emit(UserState.authorized(
              activeUser: activeUser,
              allUsers: allUsers,
            ));
            addSingleResult(const UserSingleResult.signInSucceed());
          },
        );
      },
    );
  }
}
