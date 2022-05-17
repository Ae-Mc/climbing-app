import 'package:climbing_app/arch/single_result_bloc/single_result_bloc.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_ascent/domain/entities/ascent_create.dart';
import 'package:climbing_app/features/add_ascent/domain/repositories/add_ascent_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'add_ascent_event.dart';
part 'add_ascent_single_result.dart';
part 'add_ascent_state.dart';
part 'add_ascent_bloc.freezed.dart';

@injectable
class AddAscentBloc extends SingleResultBloc<AddAscentEvent, AddAscentState,
    AddAscentSingleResult> {
  final AddAscentRepository repository;

  AddAscentBloc(this.repository) : super(const AddAscentState.loaded()) {
    on<AddAscentEvent>((event, emit) async {
      emit(const AddAscentState.loading());
      await event.when<Future<void>>(
        addAscent: (ascent) async => (await repository.addAscent(ascent)).fold(
          (l) {
            emit(const AddAscentState.loaded());
            addSingleResult(AddAscentSingleResult.failure(l));
          },
          (r) {
            emit(const AddAscentState.loaded());
            addSingleResult(const AddAscentSingleResult.success());
          },
        ),
      );
    });
  }
}
