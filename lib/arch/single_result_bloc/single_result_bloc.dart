import 'package:bloc/bloc.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_mixin.dart';

/// Абстракция для расширения возможностей блок для отправки SingleResult - событий которые необходимо отрендерить 1 раз
/// - Навгиация
/// - Тост
/// - Снек
/// - Какое-то взаимодействие с анимацией
abstract class SingleResultBloc<Event, State, SingleResult>
    extends Bloc<Event, State>
    with SingleResultMixin<Event, State, SingleResult> {
  SingleResultBloc(State state) : super(state);
}
