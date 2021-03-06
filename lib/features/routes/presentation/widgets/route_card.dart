import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/util/category_to_color.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/widgets/custom_network_image.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart' hide Route;

class RouteCard extends StatelessWidget {
  final Route route;
  const RouteCard({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: () => openDetailsPage(context),
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
                          route.images[0].url,
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
                        '??????????????????: ${route.category}',
                        style: textTheme.subtitle2,
                      ),
                      Text(
                        '??????????: ${route.author.firstName} ${route.author.lastName}',
                        style: textTheme.subtitle2,
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
      ),
    );
  }

  void openDetailsPage(BuildContext context) {
    // ignore: avoid-ignoring-return-values
    AutoRouter.of(context).push(RouteDetailsRoute(route: route));
  }
}
