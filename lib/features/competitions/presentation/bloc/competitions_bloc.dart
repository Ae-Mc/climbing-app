import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/competitions/domain/entities/competition_create.dart';
import 'package:climbing_app/features/competitions/domain/repositories/competitions_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

part 'competitions_bloc.freezed.dart';
part 'competitions_event.dart';
part 'competitions_single_result.dart';
part 'competitions_state.dart';

@injectable
class CompetitionsBloc extends SingleResultBloc<CompetitionsEvent,
    CompetitionsState, CompetitionsSingleResult> {
  final CompetitionsRepository repository;

  CompetitionsBloc(this.repository) : super(const CompetitionsState.loaded()) {
    on<CompetitionsEvent>((event, emit) async {
      switch (event) {
        case CompetitionsEventAddCompetition(:final competition):
          emit(const CompetitionsState.loading());
          (await repository.addCompetition(competition)).fold(
            (l) {
              addSingleResult(CompetitionsSingleResult.failure(l));
              emit(const CompetitionsState.loaded());
            },
            (r) {
              addSingleResult(const CompetitionsSingleResult.success());
              emit(const CompetitionsState.loaded());
            },
          );
        case CompetitionsEventRemoveCompetition(:final competitionId):
          emit(const CompetitionsState.loading());
          (await repository.removeCompetition(competitionId)).fold(
            (l) {
              addSingleResult(CompetitionsSingleResult.failure(l));
              emit(const CompetitionsState.loaded());
            },
            (r) {
              addSingleResult(const CompetitionsSingleResult.success());
              emit(const CompetitionsState.loaded());
            },
          );
      }
    });
  }
}
