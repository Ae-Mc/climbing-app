import 'package:climbing_app/features/add_route/domain/entities/route_create.dart';
import 'package:climbing_app/features/add_route/domain/repositories/add_route_repository.dart';
import 'package:climbing_app/features/add_route/presentation/bloc/add_route_single_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

import 'add_route_event.dart';
import 'add_route_state.dart';

@injectable
class AddRouteBloc extends SingleResultBloc<AddRouteEvent, AddRouteState,
    AddRouteSingleResult> {
  final AddRouteRepository repository;

  AddRouteBloc(this.repository) : super(const AddRouteState.data()) {
    on<AddRouteEvent>((event, emit) async {
      switch (state) {
        case AddRouteStateData state:
          switch (event) {
            case AddRouteEventSetName(:var name):
              emit(state.copyWith(name: name));
            case AddRouteEventSetMarksColor(:var marksColor):
              emit(state.copyWith(color: marksColor));
            case AddRouteEventSetDate(:var date):
              emit(state.copyWith(date: date));
            case AddRouteEventSetDescription(:var description):
              emit(state.copyWith(description: description));
            case AddRouteEventSetCategory(:var category):
              emit(state.copyWith(category: category));
            case AddRouteEventSetImages(:var images):
              emit(state.copyWith(images: images));
            case AddRouteEventUploadRoute():
              await upload(state, emit);
          }
        case AddRouteStateLoading():
          throw UnimplementedError('Impossible state');
      }
    });
  }

  Future<void> upload(
    AddRouteStateData dataState,
    Emitter<AddRouteState> emit,
  ) async {
    emit(const AddRouteState.loading());
    final route = RouteCreate(
      category: dataState.category!,
      creationDate: GetIt.I<DateFormat>().format(dataState.date!),
      description: dataState.description!,
      images: dataState.images ?? [],
      markColor: dataState.color!,
      name: dataState.name!,
    );
    (await repository.addRoute(route)).fold(
      (l) {
        addSingleResult(AddRouteSingleResult.failure(l));
        emit(dataState);
      },
      (r) {
        addSingleResult(const AddRouteSingleResult.addedSuccessfully());
        emit(dataState);
      },
    );
  }
}
