import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:climbing_app/features/rating/presentation/providers/user_rating.dart';
import 'package:climbing_app/features/rating/presentation/widgets/ascent_card.dart';
import 'package:climbing_app/features/rating/presentation/widgets/participation_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

@RoutePage()
class UserRatingPage extends ConsumerStatefulWidget {
  final Score score;

  const UserRatingPage({super.key, required this.score});

  @override
  ConsumerState<UserRatingPage> createState() => _UserRatingPageState();
}

class _UserRatingPageState extends ConsumerState<UserRatingPage> {
  final lastCountedDate = DateTime.now()
      .subtract(const Duration(days: 45))
      .copyWith(hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;
    final provider = userRatingProvider(widget.score.user.id);
    final best5AscentsHeader = [
      Text(
        "5 лучших пролазов",
        style: textTheme.title,
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
      const SizedBox(height: 16),
    ];

    final ascents = ref.watch(provider);
    ref.listen(
      provider,
      (previous, next) {
        if (next.hasError && !next.isLoading) {
          late final String errorText;
          final error = next.error!;
          GetIt.I<Logger>().e(error);
          switch (error) {
            case DioException(:final response, :final requestOptions)
                when response != null:
              GetIt.I<Logger>().e(response.data);
              GetIt.I<Logger>().e(requestOptions.uri);
              errorText = "Ошибка сервера. Код ошибки: ${response.statusCode}";
            case _:
              errorText = "Ошибка загрузки. Проверьте интернет соединение";
          }
          CustomToast(context).showTextFailureToast(errorText);
        }
      },
    );

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomSliverAppBar(
            text:
                '${widget.score.user.lastName} ${widget.score.user.firstName}',
            leading: const BackButton(),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            // ignore: unused_result
            await ref.refresh(provider.future);
          },
          child: CustomScrollView(
            slivers: [
              // Slivers
              SliverPadding(
                padding: const Pad(all: 16),
                sliver: SliverList.list(
                  children: [
                    if (widget.score.participations.isNotEmpty) ...[
                      Text(
                        "Соревнования",
                        style: textTheme.title,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ...widget.score.participations.indexed.map(
                        (e) => Padding(
                          padding: const Pad(bottom: 16),
                          child: ParticipationCard(
                              competitionParticipantRead: e.$2),
                        ),
                      )
                    ],
                    ascents.when(
                      data: (ascents) => Column(
                        children: [
                          if (ascents.isNotEmpty) ...best5AscentsHeader,
                          ...ascents
                              .map((e) => Padding(
                                    padding: const Pad(bottom: 16),
                                    child: AscentCard(ascent: e),
                                  ))
                              .toList(),
                        ],
                      ),
                      error: (error, stackTrace) {
                        return Column(
                          children: [
                            ...best5AscentsHeader,
                            Center(
                              child: FloatingActionButton(
                                onPressed: () async => ref.invalidate(provider),
                                foregroundColor: colorTheme.onSecondary,
                                child: const Icon(Icons.refresh),
                              ),
                            ),
                          ],
                        );
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    if (widget.score.ascents.isEmpty &&
                        ascents.valueOrNull?.isEmpty == true)
                      Text(
                        "Этот пользователь пока не участвовал в спортивной деятельности секции",
                        style: textTheme.subtitle1,
                        textAlign: TextAlign.center,
                        maxLines: 5,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
