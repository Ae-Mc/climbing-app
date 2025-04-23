import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/domain/repositories/routes_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

part 'routes_bloc_event.dart';
part 'routes_bloc_single_result.dart';
part 'routes_bloc_state.dart';
part 'routes_bloc.freezed.dart';

@injectable
class RoutesBloc extends SingleResultBloc<RoutesBlocEvent, RoutesBlocState,
    RoutesBlocSingleResult> {
  final RoutesRepository routesRepository;

  RoutesBloc(this.routesRepository) : super(const RoutesBlocState.loading()) {
    on<RoutesBlocEvent>((event, emit) async {
      switch (event) {
        case RoutesBlocEventLoadRoutes(:final archived):
          emit(const RoutesBlocState.loading());
          (await routesRepository.getAllRoutes(archived)).fold(
            (left) {
              if (left is ConnectionFailure) {
                emit(const RoutesBlocState.connectionFailure());
              } else if (left is ServerFailure) {
                emit(RoutesBlocState.serverFailure(left));
              } else {
                emit(const RoutesBlocState.unknownFailure());
              }
              addSingleResult(RoutesBlocSingleResult.failure(left));
            },
            (right) => emit(RoutesBlocState.loaded(right)),
          );
        case RoutesBlocEventRemoveRoute(:final route):
          addSingleResult(
            (await routesRepository.removeRoute(route)).fold(
              RoutesBlocSingleResult.failure,
              (r) {
                add(const RoutesBlocEvent.loadRoutes());

                return const RoutesBlocSingleResult.removeRouteSuccess();
              },
            ),
          );
      }
    });
  }
}
