import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final bool isHighlighted;
  final int place;
  final double score;
  final String user;

  const ScoreCard({
    Key? key,
    required this.place,
    required this.score,
    required this.user,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;
    Color borderColor;

    switch (place) {
      case 1:
        borderColor = colorTheme.gold;
        break;
      case 2:
        borderColor = colorTheme.silver;
        break;
      case 3:
        borderColor = colorTheme.bronze;
        break;
      default:
        borderColor = colorTheme.secondaryVariant;
    }

    return Card(
      shape: isHighlighted
          ? (Theme.of(context).cardTheme.shape as RoundedRectangleBorder)
              .copyWith(
              side: BorderSide(color: colorTheme.primary, width: 2),
            )
          : null,
      child: Padding(
        padding: const Pad(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: borderColor, width: 5),
              ),
              width: 72,
              height: 72,
              child: Text(
                place.toString(),
                style: textTheme.title,
              ),
            ),
            const SizedBox(width: 16),
            Text(user, style: textTheme.subtitle1, maxLines: 3),
            const SizedBox(width: 16),
            const Spacer(),
            Text(
              trimRight(trimRight(score.toStringAsFixed(1), '0'), '.'),
              style: textTheme.title,
            ),
          ],
        ),
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
