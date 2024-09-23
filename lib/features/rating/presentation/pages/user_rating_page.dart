import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:climbing_app/features/rating/presentation/widgets/ascent_card.dart';
import 'package:climbing_app/features/rating/presentation/widgets/participation_card.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserRatingPage extends StatefulWidget {
  final Score score;

  const UserRatingPage({super.key, required this.score});

  @override
  State<UserRatingPage> createState() => _UserRatingPageState();
}

class _UserRatingPageState extends State<UserRatingPage> {
  final lastCountedDate = DateTime.now()
      .subtract(const Duration(days: 45))
      .copyWith(hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            text:
                '${widget.score.user.lastName} ${widget.score.user.firstName}',
            leading: const BackButton(),
          ),
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
                      child:
                          ParticipationCard(competitionParticipantRead: e.$2),
                    ),
                  )
                ],
                if (widget.score.ascents.isNotEmpty) ...[
                  Text(
                    "Пролазы",
                    style: textTheme.title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ...widget.score.ascents.indexed.map(
                    (e) => Padding(
                      padding: const Pad(bottom: 16),
                      child: AscentCard(
                          ascent: e.$2,
                          highlightColor:
                              e.$2.date.compareTo(lastCountedDate) >= 0
                                  ? e.$1 < 5
                                      ? colorTheme.ascentTop5
                                      : colorTheme.ascentActual
                                  : null),
                    ),
                  )
                ],
                if (widget.score.ascents.isEmpty &&
                    widget.score.participations.isEmpty)
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
    );
  }
}
