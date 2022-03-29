import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import 'add_route_event.dart';
import 'add_route_state.dart';

@injectable
class AddRouteBloc extends Bloc<AddRouteEvent, AddRouteState> {
  AddRouteBloc() : super(const AddRouteState.initial()) {
    on<AddRouteEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
