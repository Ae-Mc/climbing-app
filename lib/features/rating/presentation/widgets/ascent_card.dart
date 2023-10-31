import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/ink_well_card.dart';
import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class AscentCard extends StatelessWidget {
  final AscentRead ascent;
  final Color? highlightColor;

  const AscentCard({super.key, required this.ascent, this.highlightColor});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    var shape = Theme.of(context).cardTheme.shape;
    final highlightColor = this.highlightColor;

    if (shape is OutlinedBorder && highlightColor != null) {
      shape = shape.copyWith(side: BorderSide(color: highlightColor, width: 2));
    }

    return InkWellCard(
      shapeModifier: (_) => highlightColor == null ? null : shape,
      onTap: () => context.pushRoute(RouteDetailsRoute(route: ascent.route)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: ascent.route.images.isNotEmpty
                ? CustomNetworkImage(
                    ascent.route.images[0].url,
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
                  ascent.route.name,
                  style: textTheme.subtitle1,
                ),
                Text(
                  'Категория: ${ascent.route.category}',
                  style: textTheme.subtitle2,
                ),
                Text(
                  'Дата пролаза: ${GetIt.I<DateFormat>().format(ascent.date)}',
                  style: textTheme.subtitle2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
