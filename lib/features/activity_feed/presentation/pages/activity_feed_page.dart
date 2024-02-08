import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/universal_bloc/universal_bloc.dart';
import 'package:climbing_app/core/entities/ascent.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/activity_feed/domain/repositories/activity_feed_repository.dart';
import 'package:climbing_app/features/activity_feed/presentation/widgets/ascent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

@RoutePage()
class ActivityFeedPage extends StatelessWidget {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  ActivityFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = AppTheme.of(context).textTheme;

    return BlocProvider(
      create: (_) => UniversalBloc(
        () => GetIt.I<ActivityFeedRepository>().recentAscents(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleResultBlocBuilder<
              UniversalBloc<List<Ascent>>,
              UniversalBlocState<List<Ascent>>,
              UniversalBlocSingleResult<List<Ascent>>>(
            onSingleResult: (context, singleResult) => singleResult.whenOrNull(
              failure: (value) => CustomToast(context)
                  .showTextFailureToast(failureToText(value)),
            ),
            builder: (context, state) => RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () async => await refresh(
                  BlocProvider.of<UniversalBloc<List<Ascent>>>(context)),
              edgeOffset: 64,
              child: CustomScrollView(
                slivers: [
                  const CustomSliverAppBar(
                    text: 'Недавние пролазы секции',
                    leading: BackButton(),
                  ),
                  state.when<Widget>(
                    failure: (f) => SliverFillRemaining(
                      child: Center(child: Text(failureToText(f))),
                    ),
                    loaded: (ascents) => SliverPadding(
                      padding: const Pad(all: 16),
                      sliver: SliverList.separated(
                        itemCount: ascents.isEmpty ? 1 : ascents.length,
                        itemBuilder: (context, index) => (ascents.isEmpty)
                            ? Center(
                                child: Text(
                                  'В последнее время в секции не было добавлено пролазов',
                                  style: textTheme.subtitle1,
                                  maxLines: 2,
                                ),
                              )
                            : (ascents)
                                .map((e) => AscentCard(
                                      ascent: e,
                                    ))
                                .elementAt(index),
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                      ),
                    ),
                    loading: () => const SliverFillRemaining(
                      child: Center(child: CustomProgressIndicator()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refresh(UniversalBloc<List<Ascent>> bloc) async {
    bloc.add(const UniversalBlocEvent.refresh());
    // ignore: avoid-ignoring-return-values
    await bloc.stream.first;
  }
}
