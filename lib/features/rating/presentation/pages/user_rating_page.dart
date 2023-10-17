import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_sliver_app_bar.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserRatingPage extends StatelessWidget {
  final Score score;

  const UserRatingPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            text: '${score.user.lastName} ${score.user.firstName}',
            leadingBuilder: (context) => const BackButton(),
          ),
          // Slivers
          SliverPadding(
            padding: const Pad(all: 8),
            sliver: SliverList.list(
              children: [
                const SizedBox(height: 16),
                if (score.participations.isNotEmpty) ...[
                  Text(
                    "Соревнования",
                    style: textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
                if (score.ascents.isNotEmpty) ...[
                  Text(
                    "Пролазы",
                    style: textTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
                if (score.ascents.isEmpty && score.participations.isEmpty)
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
