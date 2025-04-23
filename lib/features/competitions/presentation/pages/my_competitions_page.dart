import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/universal_bloc/universal_bloc.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/competitions/domain/repositories/competitions_repository.dart';
import 'package:climbing_app/features/competitions/presentation/bloc/competitions_bloc.dart';
import 'package:climbing_app/features/competitions/presentation/widgets/competition_card.dart';
import 'package:climbing_app/features/rating/domain/entities/competition_read.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

typedef CompList = List<CompetitionRead>;

@RoutePage()
class MyCompetitionsPage extends StatelessWidget {
  const MyCompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UniversalBloc(
          () => GetIt.I<CompetitionsRepository>().getCurrentUserCompetitions()),
      child: Scaffold(
        body: SafeArea(
          child: SingleResultBlocBuilder<CompetitionsBloc, CompetitionsState,
              CompetitionsSingleResult>(
            onSingleResult: (context, singleResult) => switch (singleResult) {
              CompetitionsSingleResultFailure(:final failure) =>
                CustomToast(context)
                    .showTextFailureToast(failureToText(failure)),
              CompetitionsSingleResultSuccess() =>
                BlocProvider.of<UniversalBloc<CompList>>(context)
                    .add(const UniversalBlocEvent.refresh()),
            },
            builder: (context, state) => SingleResultBlocBuilder<
                UniversalBloc<CompList>,
                UniversalBlocState<CompList>,
                UniversalBlocSingleResult<CompList>>(
              onSingleResult: (context, singleResult) => switch (singleResult) {
                UniversalBlocSingleResultFailure(:final failure) =>
                  CustomToast(context)
                      .showTextFailureToast(failureToText(failure)),
                _ => null
              },
              builder: (context, state) => RefreshIndicator.adaptive(
                onRefresh: () async =>
                    BlocProvider.of<UniversalBloc<CompList>>(context)
                        .add(const UniversalBlocEvent.refresh()),
                child: CustomScrollView(
                  slivers: [
                    const CustomSliverAppBar(
                      text: 'Добавленные соревнования',
                      leading: BackButton(),
                    ),
                    SliverPadding(
                      padding: const Pad(all: 16),
                      sliver: SliverList.list(
                        children: [
                          const SizedBox(height: 16),
                          ...switch (state) {
                            UniversalBlocStateFailure() => const [],
                            UniversalBlocStateLoaded(
                              result: final competitions
                            ) =>
                              competitions.isEmpty
                                  ? [
                                      Text(
                                        'Вы ещё не добавляли соревнования!',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.of(context)
                                            .textTheme
                                            .body2Regular,
                                      )
                                    ]
                                  : competitions
                                      .map(
                                        (e) => CompetitionCard(
                                          competition: e,
                                          showDeleteButton: true,
                                        ),
                                      )
                                      .toList(),
                            UniversalBlocStateLoading() => const [],
                          }
                        ],
                      ),
                    ),
                    if (state is UniversalBlocStateLoading)
                      SliverFillRemaining(
                        child: Center(
                            child: switch (state) {
                          UniversalBlocStateFailure() => ElevatedButton(
                              onPressed: () =>
                                  BlocProvider.of<UniversalBloc<CompList>>(
                                          context)
                                      .add(const UniversalBlocEvent.refresh()),
                              style: const ButtonStyle(
                                alignment: Alignment.center,
                                shape: WidgetStatePropertyAll(
                                  CircleBorder(),
                                ),
                              ),
                              child: const Icon(Icons.refresh),
                            ),
                          UniversalBlocStateLoaded() => const SizedBox(),
                          UniversalBlocStateLoading() =>
                            const CircularProgressIndicator.adaptive(),
                        }),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
