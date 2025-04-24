import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/universal_bloc/universal_bloc.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:climbing_app/features/user/presentation/widgets/expiring_ascent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class ExpiringAscentsPage extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  ExpiringAscentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;

    return BlocProvider(
      create: (context) => UniversalBloc(
        () => GetIt.I<UserRepository>().getCurrentUserExpiringAscents(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleResultBlocBuilder<
              UniversalBloc<List<ExpiringAscent>>,
              UniversalBlocState<List<ExpiringAscent>>,
              UniversalBlocSingleResult<List<ExpiringAscent>>>(
            onSingleResult: (context, singleResult) => switch (singleResult) {
              UniversalBlocSingleResultFailure(:final failure) =>
                CustomToast(context)
                    .showTextFailureToast(failureToText(failure)),
              _ => null
            },
            builder: (context, state) => RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async => await refresh(
                  BlocProvider.of<UniversalBloc<List<ExpiringAscent>>>(
                      context)),
              edgeOffset: 64,
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    text: 'Истекающие пролазы',
                    leading: BackButton(),
                  ),
                  switch (state) {
                    UniversalBlocStateFailure(:final f) => SliverFillRemaining(
                        child: Center(child: Text(failureToText(f))),
                      ),
                    UniversalBlocStateLoaded(result: final ascents) =>
                      SliverPadding(
                        padding: const Pad(all: 16),
                        sliver: SliverList.separated(
                          itemCount: ascents.isEmpty ? 1 : ascents.length,
                          itemBuilder: (context, index) => (ascents.isEmpty)
                              ? Center(
                                  child: Text(
                                    "Нет трасс, которые скоро обесценятся",
                                    style: textTheme.subtitle1,
                                    maxLines: 2,
                                  ),
                                )
                              : (ascents)
                                  .map((e) => ExpiringAscentCard(
                                        expiringAscent: e,
                                        onDelete: () => _refreshIndicatorKey
                                            .currentState
                                            ?.show(),
                                      ))
                                  .elementAt(index),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                        ),
                      ),
                    UniversalBlocStateLoading() => const SliverFillRemaining(
                        child: Center(child: CustomProgressIndicator()),
                      ),
                  }
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh(UniversalBloc<List<ExpiringAscent>> bloc) async {
    bloc.add(const UniversalBlocEvent.refresh());
    // ignore: avoid-ignoring-return-values
    await bloc.stream.first;
  }
}
