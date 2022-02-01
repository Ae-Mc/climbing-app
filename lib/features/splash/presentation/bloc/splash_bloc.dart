import 'package:climbing_app/arch/single_result_bloc/single_result_bloc.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/splash/domain/usecases/initialize.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashBloc extends SingleResultBloc<SplashBlocEvent, SplashBlocState,
    SplashBlocSingleResult> {
  final Initialize initialize;
  SplashBloc(this.initialize) : super(const SplashBlocStateNormal()) {
    on<SplashBlocEventInit>((event, emit) async {
      emit(const SplashBlocStateNormal());
      final result = await initialize(null);
      result.fold(
        (l) => emit(
          const SplashBlocStateFailure(Failure('Error in initialization')),
        ),
        (r) => addSingleResult(const SplashBlocSingleResultLoadFinished()),
      );
    });
  }
}
