import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/util/category_to_color.dart';
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:climbing_app/features/user/domain/entities/expiring_ascent.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class ExpiringAscentCard extends StatelessWidget {
  final ExpiringAscent expiringAscent;

  const ExpiringAscentCard({super.key, required this.expiringAscent});

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;
    final route = expiringAscent.ascent.route;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Padding(
        padding: const Pad(horizontal: 16, vertical: 8),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: route.images.isNotEmpty
                    ? CustomNetworkImage(
                        expiringAscent.ascent.route.images[0].url,
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      )
                    : Assets.images.status404.image(
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      route.name,
                      style: textTheme.subtitle1,
                    ),
                    Text(
                      'Категория: ${route.category}',
                      style: textTheme.subtitle2,
                      maxLines: 2,
                    ),
                    Text(
                      'Осталось до исчезновения: ${durationToString(expiringAscent.timeToExpire)}',
                      style: textTheme.subtitle2,
                      maxLines: 2,
                    ),
                    const Spacer(),
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: categoryToColor(route.category, colorTheme),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
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

  static String durationToString(Duration duration) {
    final days = duration.inDays;
    String ending;

    if ((days % 100).between(10, 21) || days % 10 > 4 || days % 10 == 0) {
      ending = "дней";
    } else if (days % 10 == 1) {
      ending = "день";
    } else {
      ending = "дня";
    }

    return '$days $ending';
  }
}

extension on int {
  bool between(int start, int end) => this >= start && this < end;
}
