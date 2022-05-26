import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/repositories/routes_repository.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_event.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_single_result.dart';
import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc_state.dart';
import 'package:injectable/injectable.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@injectable
class RoutesBloc extends SingleResultBloc<RoutesBlocEvent, RoutesBlocState,
    RoutesBlocSingleResult> {
  final RoutesRepository routesRepository;

  RoutesBloc(this.routesRepository) : super(const RoutesBlocState.loading()) {
    on<RoutesBlocEventLoadRoutes>((event, emit) async {
      emit(const RoutesBlocState.loading());
      (await routesRepository.getAllRoutes()).fold(
        (left) {
          if (left is ConnectionFailure) {
            emit(const RoutesBlocState.connectionFailure());
            addSingleResult(const RoutesBlocSingleResult.connectionFailure());
          } else if (left is ServerFailure) {
            emit(RoutesBlocState.serverFailure(left));
            addSingleResult(RoutesBlocSingleResult.serverFailure(left));
          } else {
            emit(const RoutesBlocState.unknownFailure());
            addSingleResult(const RoutesBlocSingleResult.unknownFailure());
          }
        },
        (right) => emit(RoutesBlocState.loaded(right)),
      );
    });
  }
}
