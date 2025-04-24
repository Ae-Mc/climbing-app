import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/user/domain/entities/password_reset_failure.dart';
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

  Future<void> handleEvent(UserEvent event, UserEmitter emit) async {
    switch (event) {
      case UserEventFetch():
        await fetchUserData(onFailure: (_) async => 0, emit: emit);
        break;
      case UserEventInit():
        await initialize(emit);
        break;
      case UserEventSignOut():
        await signOut(emit);
        break;
      case UserEventSignIn():
        await signIn(event, emit);
        break;
      case UserEventRegister():
        await register(event, emit);
        break;
      case UserEventForgotPassword():
        await forgotPassword(event, emit);
        break;
      case UserEventResetPassword():
        await resetPassword(event, emit);
        break;
      case UserEventRemoveAscent():
        await removeAscent(event, emit);
        break;
    }
  }

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
    final previousState = switch (state) {
      UserStateAuthorized(
        :final activeUser,
        :final allUsers,
        :final userRoutes
      ) =>
        UserState.authorized(
          activeUser: activeUser,
          allUsers: allUsers,
          userRoutes: userRoutes,
        ),
      UserStateInitializationFailure(:final failure) =>
        UserState.initializationFailure(failure),
      UserStateLoading() => const UserState.loading(),
      UserStateNotAuthorized() => const UserState.notAuthorized(),
    };
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

  Future<void> forgotPassword(
      UserEventForgotPassword event, UserEmitter emit) async {
    emit(const UserState.loading());
    addSingleResult(
      (await repository.forgotPassword(event.email)).fold<UserSingleResult>(
        (failure) => UserSingleResult.failure(failure),
        (_) => const UserSingleResult.success(),
      ),
    );
    emit(const UserState.notAuthorized());
  }

  Future<void> resetPassword(
      UserEventResetPassword event, UserEmitter emit) async {
    emit(const UserState.loading());
    addSingleResult(
      (await repository.resetPassword(event.token, event.password))
          .fold<UserSingleResult>(
        (failure) => failure.fold(
          (l) => UserSingleResult.failure(l),
          (r) => UserSingleResult.passwordResetFailure(r),
        ),
        (_) => const UserSingleResult.success(),
      ),
    );
    emit(const UserState.notAuthorized());
  }

  Future<void> removeAscent(
      UserEventRemoveAscent event, UserEmitter emit) async {
    (await repository.removeAscent(event.id)).fold(
      UserSingleResult.failure,
      (r) {
        addSingleResult(const UserSingleResult.success());
        add(const UserEvent.fetch());
      },
    );
  }

  Future<void> fetchUserData({
    required Future<void> Function(Failure failure) onFailure,
    required UserEmitter emit,
  }) async {
    final allUsersFuture = repository.getAllUsers();
    final currentUserFuture = repository.getCurrentUser();
    final currentUserRoutesFuture = repository.getCurrentUserRoutes();

    await (await currentUserFuture).fold<Future<void>>(
      onFailure,
      (activeUser) async {
        await (await allUsersFuture).fold<Future<void>>(
          onFailure,
          (allUsers) async {
            await (await currentUserRoutesFuture).fold<Future<void>>(
              onFailure,
              (userRoutes) async {
                emit(UserState.authorized(
                  activeUser: activeUser,
                  allUsers: allUsers,
                  userRoutes: userRoutes,
                ));
                addSingleResult(const UserSingleResult.signInSucceed());
              },
            );
          },
        );
      },
    );
  }
}
