import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/ink_well_card.dart';
import 'package:climbing_app/features/rating/domain/entities/score.dart';
import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final bool isHighlighted;
  final Score score;

  const ScoreCard({
    super.key,
    required this.score,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;
    final Color placeCircleColor = [
          colorTheme.gold,
          colorTheme.silver,
          colorTheme.bronze
        ].elementAtOrNull(score.place - 1) ??
        colorTheme.secondaryVariant;

    return InkWellCard(
      onTap: () => context.pushRoute(UserRatingRoute(score: score)),
      shapeModifier: isHighlighted
          ? (shape) {
              if (shape is OutlinedBorder) {
                return shape.copyWith(
                    side: BorderSide(color: colorTheme.primary, width: 2));
              }
              return shape;
            }
          : null,
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: placeCircleColor, width: 5),
            ),
            width: 72,
            height: 72,
            child: Text(
              score.place.toString(),
              style: textTheme.title,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '${score.user.lastName} ${score.user.firstName}',
              style: textTheme.subtitle1,
              maxLines: 3,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            trimRight(trimRight(score.score.toStringAsFixed(1), '0'), '.'),
            style: textTheme.title,
          ),
        ],
      ),
    );
  }

  String trimRight(String str, String character) {
    int i = str.length - 1;
    // ignore: no-empty-block
    for (; i >= 0 && str[i] == character; i--) {}

    return str.substring(0, i + 1);
  }
}
