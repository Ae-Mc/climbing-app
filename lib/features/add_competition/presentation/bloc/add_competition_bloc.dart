import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/add_competition/domain/entities/competition_create.dart';
import 'package:climbing_app/features/add_competition/domain/repositories/add_competition_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

part 'add_competition_bloc.freezed.dart';
part 'add_competition_event.dart';
part 'add_competition_single_result.dart';
part 'add_competition_state.dart';

@injectable
class AddCompetitionBloc extends SingleResultBloc<AddCompetitionEvent,
    AddCompetitionState, AddCompetitionSingleResult> {
  final AddCompetitionRepository repository;

  AddCompetitionBloc(this.repository)
      : super(const AddCompetitionState.loaded()) {
    on<AddCompetitionEvent>(
      (event, emit) async => await event.when<Future<void>>(
        addCompetition: (competition) async {
          emit(const AddCompetitionState.loading());
          (await repository.addCompetition(competition)).fold(
            (l) {
              addSingleResult(AddCompetitionSingleResult.failure(l));
              emit(const AddCompetitionState.loaded());
            },
            (r) {
              addSingleResult(const AddCompetitionSingleResult.success());
              emit(const AddCompetitionState.loaded());
            },
          );
        },
      ),
    );
  }
}
