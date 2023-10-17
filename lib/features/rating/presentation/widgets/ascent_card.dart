import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/rating/domain/entities/ascent_read.dart';
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';

class AscentCard extends StatelessWidget {
  final AscentRead ascent;

  const AscentCard({super.key, required this.ascent});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.of(context).textTheme;
    return Card(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
