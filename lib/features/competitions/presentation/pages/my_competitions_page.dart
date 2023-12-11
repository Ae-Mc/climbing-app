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
            onSingleResult: (context, singleResult) => singleResult.whenOrNull(
              failure: (failure) => CustomToast(context)
                  .showTextFailureToast(failureToText(failure)),
              success: () => BlocProvider.of<UniversalBloc<CompList>>(context)
                  .add(const UniversalBlocEvent.refresh()),
            ),
            builder: (context, state) => SingleResultBlocBuilder<
                UniversalBloc<CompList>,
                UniversalBlocState<CompList>,
                UniversalBlocSingleResult<CompList>>(
              onSingleResult: (context, singleResult) => singleResult.when(
                loaded: (_) => null,
                failure: (failure) => CustomToast(context)
                    .showTextFailureToast(failureToText(failure)),
              ),
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
                          ...state.when(
                            failure: (_) => const [],
                            loaded: (competitions) => competitions.isEmpty
                                ? [
                                    Text(
                                      'Вы ещё не добавляли соревнования!',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.of(context)
                                          .textTheme
                                          .body2Regular,
                                    )
                                  ]
                                : competitions.map(
                                    (e) => CompetitionCard(
                                      competition: e,
                                      showDeleteButton: true,
                                    ),
                                  ),
                            loading: () => const [],
                          )
                        ],
                      ),
                    ),
                    if (state.mapOrNull(
                            loading: (_) => true, failure: (_) => true) ??
                        false)
                      SliverFillRemaining(
                        child: Center(
                          child: state.map(
                              failure: (_) => ElevatedButton(
                                    onPressed: () => BlocProvider.of<
                                            UniversalBloc<CompList>>(context)
                                        .add(
                                            const UniversalBlocEvent.refresh()),
                                    style: const ButtonStyle(
                                      alignment: Alignment.center,
                                      shape: MaterialStatePropertyAll(
                                        CircleBorder(),
                                      ),
                                    ),
                                    child: const Icon(Icons.refresh),
                                  ),
                              loaded: (_) => const SizedBox(),
                              loading: (_) =>
                                  const CircularProgressIndicator.adaptive()),
                        ),
                      )
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
