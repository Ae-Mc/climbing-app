import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/rating/presentation/bloc/rating_bloc.dart';
import 'package:climbing_app/features/rating/presentation/widgets/score_card.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class RatingPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return BlocProvider(
      create: (context) =>
          GetIt.I<RatingBloc>()..add(const RatingEvent.refresh()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) => SingleResultBlocBuilder<RatingBloc,
            RatingState, RatingSingleResult>(
          onSingleResult: (context, singleResult) => singleResult.when(
            failure: (failure) => CustomToast(context)
                .showTextFailureToast(failureToText(failure)),
          ),
          buildWhen: (oldState, newState) =>
              newState.map(loaded: (_) => true, loading: (_) => false),
          builder: (context, state) => state.when(
            loaded: (scores, mustBeStudent) => RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async => await onRefresh(context),
              child: CustomScrollView(
                slivers: [
                  CustomSliverAppBar(
                    text: 'Рейтинг',
                    actions: [
                      IconButton(
                        onPressed: () =>
                            changeMustBeStudent(context, mustBeStudent),
                        icon: Icon(
                          Icons.school_outlined,
                          color: mustBeStudent
                              ? colorTheme.primary
                              : colorTheme.unselected,
                        ),
                        tooltip: "Рейтинг среди студентов",
                      ),
                    ],
                  ),
                  SliverPadding(
                    padding: const Pad(all: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index % 2 == 1) {
                            return const SizedBox(height: 16);
                          }

                          final realIndex = index ~/ 2;
                          final score = scores[realIndex];

                          return ScoreCard(
                            isHighlighted: userState.maybeWhen(
                              authorized: (activeUser, allUsers, _) =>
                                  activeUser.id == score.user.id,
                              orElse: () => false,
                            ),
                            score: score,
                          );
                        },
                        childCount: scores.length * 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            loading: (_) => const Center(child: CustomProgressIndicator()),
          ),
        ),
      ),
    );
  }

  changeMustBeStudent(BuildContext context, bool mustBeStudent) {
    BlocProvider.of<RatingBloc>(context)
        .add(RatingEvent.setMustBeStudent(!mustBeStudent));
    _refreshIndicatorKey.currentState?.show();
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
