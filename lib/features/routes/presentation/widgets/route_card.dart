import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart' hide Route;

class RouteCard extends StatelessWidget {
  final Route route;
  const RouteCard({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return Builder(
      builder: (context) {
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
                          ? Image.network(
                              'http://192.168.1.56:8000/${route.images[0].url}',
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
                            style: AppTheme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'Категория: ${route.category}',
                            style: AppTheme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            'Автор: ${route.author.firstName} ${route.author.lastName}',
                            style: AppTheme.of(context).textTheme.subtitle2,
                          ),
                          const Spacer(),
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: getCategoryColor(colorTheme),
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
      },
    );
  }

  void openDetailsPage(BuildContext context) {
    // ignore: avoid-ignoring-return-values
    AutoRouter.of(context).push(RouteDetailsRoute(route: route));
  }

  Color getCategoryColor(AppColorTheme colorTheme) {
    if (route.category.index < Category('6c').index) {
      return colorTheme.routeEasy;
    }
    if (route.category.index < Category('7a+').index) {
      return colorTheme.routeMedium;
    }

    return colorTheme.routeHard;
  }
}
