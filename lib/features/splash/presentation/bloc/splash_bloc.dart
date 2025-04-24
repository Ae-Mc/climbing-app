import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/splash/domain/repositories/startup_repository.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

class SplashBloc
    extends SingleResultBloc<SplashEvent, SplashState, SplashSingleResult> {
  final StartupRepository repository;

  SplashBloc(this.repository) : super(const SplashState.loading()) {
    on<SplashEvent>((event, emit) async {
      emit(const SplashState.loading());
      // ignore: avoid-ignoring-return-values
      switch (event) {
        case SplashEventInit():
          parseResult(await repository.initialize(), emit);
        case SplashEventRetryInitialization():
          parseResult(await repository.retryInitialization(), emit);
      }
    });
  }

  void parseResult(
    Either<List<Failure>, void> result,
    Emitter<SplashState> emit,
  ) {
    result.fold(
      (l) {
        addSingleResult(SplashSingleResult.failure(l.first));
        emit(SplashState.failure(l.first));
      },
      (r) => emit(const SplashState.loaded()),
    );
  }
}
