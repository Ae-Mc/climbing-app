import 'package:climbing_app/arch/single_result_bloc/single_result_bloc.dart';
import 'package:climbing_app/core/failure.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:climbing_app/features/rating/domain/repositories/rating_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'rating_event.dart';
part 'rating_single_result.dart';
part 'rating_state.dart';
part 'rating_bloc.freezed.dart';

@injectable
class RatingBloc
    extends SingleResultBloc<RatingEvent, RatingState, RatingSingleResult> {
  final RatingRepository repository;

  RatingBloc(this.repository) : super(const RatingState.loaded([])) {
    on<RatingEvent>((event, emit) async {
      await event.when<Future<void>>(
        refresh: () async {
          final previousScores =
              state.when(loaded: (scores) => scores, loading: () => <Score>[]);
          emit(const RatingState.loading());

          return (await repository.getRating()).fold(
            (l) {
              addSingleResult(RatingSingleResult.failure(l));
              emit(RatingState.loaded(previousScores));
            },
            (r) => emit(RatingState.loaded(r)),
          );
        },
      );
    });
  }
}
