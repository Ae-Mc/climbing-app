import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/features/rating/presentation/bloc/rating_bloc.dart';
import 'package:climbing_app/features/rating/presentation/widgets/score_card.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return BlocProvider(
      create: (context) =>
          GetIt.I<RatingBloc>()..add(const RatingEvent.refresh()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return SingleResultBlocBuilder<RatingBloc, RatingState,
                  RatingSingleResult>(
                onSingleResult: (context, singleResult) => singleResult.when(
                  failure: (failure) => CustomToast(context)
                      .showTextFailureToast(failureToText(failure)),
                ),
                buildWhen: (oldState, newState) =>
                    newState.map(loaded: (_) => true, loading: (_) => false),
                builder: (context, state) => state.when(
                  loaded: (scores) => RefreshIndicator(
                    onRefresh: () async => await onRefresh(context),
                    child: ListView.separated(
                      padding: const Pad(all: 16),
                      itemCount: scores.length + 1,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Text(
                              'Рейтинг',
                              style: textTheme.title,
                              textAlign: TextAlign.center,
                            );
                          default:
                            final score = scores[index - 1];
                            return ScoreCard(
                              isHighlighted: userState.maybeWhen(
                                authorized: (activeUser, allUsers) =>
                                    activeUser.id == score.user.id,
                                orElse: () => false,
                              ),
                              place: index,
                              score: score.score,
                              user:
                                  '${score.user.lastName} ${score.user.firstName}',
                            );
                        }
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 16),
                    ),
                  ),
                  loading: () => const Center(child: CustomProgressIndicator()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    final bloc = BlocProvider.of<RatingBloc>(context);
    bloc.add(const RatingEvent.refresh());
    // ignore: avoid-ignoring-return-values
    await bloc.stream.firstWhere(
      (element) => element.map(loaded: (_) => true, loading: (_) => false),
    );
  }
}
