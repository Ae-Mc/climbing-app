import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/universal_bloc/universal_bloc.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_back_button.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
import 'package:climbing_app/features/user/domain/repositories/user_repository.dart';
import 'package:climbing_app/features/user/presentation/widgets/expiring_ascent_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:single_result_bloc/single_result_bloc_builder.dart';

class ExpiringAscentsPage extends StatelessWidget {
  const ExpiringAscentsPage({Key? key}) : super(key: key);

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
            onSingleResult: (context, singleResult) => singleResult.whenOrNull(
              failure: (value) => CustomToast(context)
                  .showTextFailureToast(failureToText(value)),
            ),
            builder: (context, state) => LayoutBuilder(
              builder: (context, constraints) => RefreshIndicator(
                onRefresh: () async => await refresh(
                  BlocProvider.of<UniversalBloc<List<ExpiringAscent>>>(context),
                ),
                child: state.when<Widget>(
                  failure: (f) => ListView(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                        child: Center(child: Text(failureToText(f))),
                      ),
                    ],
                  ),
                  loaded: (ascents) => ListView.separated(
                    padding: const Pad(all: 16),
                    itemCount: ascents.length + 1,
                    itemBuilder: (context, index) => [
                      Row(
                        children: [
                          const CustomBackButton(),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              '????????????, ?????????????? ?????????? ???????????????? ???? ????????????????',
                              style: textTheme.title,
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                      ...(ascents as List<ExpiringAscent>)
                          .map((e) => ExpiringAscentCard(expiringAscent: e))
                          .toList(),
                    ][index],
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                  ),
                  loading: () => const Center(child: CustomProgressIndicator()),
                ),
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
