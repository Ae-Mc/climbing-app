import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/splash/domain/usecases/initialize.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashBlocEvent, SplashBlocState> {
  final Initialize initialize;
  SplashBloc(this.initialize) : super(const SplashBlocState.loading()) {
    on<SplashBlocEventInit>((event, emit) async {
      emit(const SplashBlocState.loading());
      (await initialize(null)).fold(
        (l) => emit(const SplashBlocState.failure(UnknownFailure())),
        (r) => emit(const SplashBlocState.loaded()),
      );
    });
  }
}
