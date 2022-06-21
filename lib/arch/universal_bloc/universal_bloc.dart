import 'package:climbing_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

part 'universal_bloc.freezed.dart';
part 'universal_bloc_event.dart';
part 'universal_bloc_single_result.dart';
part 'universal_bloc_state.dart';

class UniversalBloc<T> extends SingleResultBloc<UniversalBlocEvent,
    UniversalBlocState<T>, UniversalBlocSingleResult<T>> {
  UniversalBloc(Future<Either<Failure, T>> Function() futureGenerator)
      : super(const UniversalBlocState.loading()) {
    on<UniversalBlocEvent>(
      (event, emit) async => await event.when<Future<void>>(
        refresh: () async {
          final UniversalBlocState<T>? previousState = state.maybeMap(
            loaded: (value) => value.copyWith() as UniversalBlocState<T>,
            orElse: () => null,
          );
          emit(const UniversalBlocState.loading());
          (await futureGenerator()).fold(
            (l) {
              addSingleResult(UniversalBlocSingleResult<T>.failure(l));
              if (previousState != null) {
                emit(previousState);
              } else {
                emit(UniversalBlocState<T>.failure(l));
              }
            },
            (r) {
              addSingleResult(UniversalBlocSingleResult<T>.loaded(r));
              emit(UniversalBlocState<T>.loaded(r));
            },
          );
        },
      ),
    );
    add(const UniversalBlocEvent.refresh());
  }
}
