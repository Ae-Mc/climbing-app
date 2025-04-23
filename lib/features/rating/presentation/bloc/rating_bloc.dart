import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:climbing_app/features/rating/domain/repositories/rating_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

part 'rating_event.dart';
part 'rating_single_result.dart';
part 'rating_state.dart';
part 'rating_bloc.freezed.dart';

@injectable
class RatingBloc
    extends SingleResultBloc<RatingEvent, RatingState, RatingSingleResult> {
  final RatingRepository repository;

  RatingBloc(this.repository)
      : super(const RatingState.loaded([], false, false)) {
    on<RatingEvent>((event, emit) async {
      switch (event) {
        case RatingEventRefresh():
          final previousState = state;
          emit(RatingState.loading(
            previousState.mustBeStudent,
            previousState.mustBeFemale,
          ));

          return (await repository.getRating(
            previousState.mustBeStudent,
            previousState.mustBeFemale,
          ))
              .fold(
            (l) {
              addSingleResult(RatingSingleResult.failure(l));
              emit(RatingState.loaded(
                previousState is RatingStateLoaded ? previousState.scores : [],
                previousState.mustBeStudent,
                previousState.mustBeFemale,
              ));
            },
            (r) => emit(RatingState.loaded(
                r, previousState.mustBeStudent, previousState.mustBeFemale)),
          );
        case RatingEventSetMustBeStudent(:final mustBeStudent):
          emit(RatingState.loading(mustBeStudent, state.mustBeFemale));
          add(const RatingEvent.refresh());
        case RatingEventSetMustBeFemale(:final mustBeFemale):
          emit(RatingState.loading(state.mustBeStudent, mustBeFemale));
          add(const RatingEvent.refresh());
      }
    });
  }
}
