import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:climbing_app/features/rating/presentation/providers/user_rating.dart';
import 'package:climbing_app/features/rating/presentation/widgets/ascent_card.dart';
import 'package:climbing_app/features/rating/presentation/widgets/centered_text_with_button.dart';
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
    final ascentsHeader = [
      CenteredTextWithButton(
        text: "Последние пролазы",
        textStyle: textTheme.title,
        button: IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("О цветовой индикации"),
              contentPadding: Pad(all: 16),
              actions: [
                TextButton(
                  onPressed: () => context.pop(),
                  child: const Text('Понятно'),
                ),
              ],
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(children: [
                      WidgetSpan(
                        child: Box(
                          color: colorTheme.ascentTop5,
                          width: textTheme.body2Regular.fontSize,
                          height: textTheme.body2Regular.fontSize,
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' рамкой обведены актуальные пролазы, используемые при подсчёте рейтинга\n',
                      ),
                      WidgetSpan(
                        child: Box(
                          color: colorTheme.ascentActual,
                          width: textTheme.body2Regular.fontSize,
                          height: textTheme.body2Regular.fontSize,
                        ),
                      ),
                      const TextSpan(
                        text:
                            ' рамкой обведены актуальные пролазы, не используемые при подсчёте рейтинга из-за наличия лучших пролазов',
                      ),
                    ]),
                    style: textTheme.body2Regular,
                    maxLines: 15,
                  ),
                ],
              ),
            ),
          ),
          icon: const Icon(Icons.help_outline),
        ),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (ascents.isNotEmpty) ...ascentsHeader,
                          ...ascents.asMap().entries.map((e) => Padding(
                                padding: const Pad(bottom: 16),
                                child: AscentCard(
                                  ascent: e.value,
                                  highlightColor: e.value.takenInAccount
                                      ? switch (e.key) {
                                          < 5 => colorTheme.ascentTop5,
                                          _ => colorTheme.ascentActual
                                        }
                                      : null,
                                ),
                              )),
                        ],
                      ),
                      error: (error, stackTrace) {
                        return Column(
                          children: [
                            ...ascentsHeader,
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
