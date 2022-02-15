import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/domain/repositories/routes_repository.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_card.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class RoutesPage extends StatelessWidget {
  const RoutesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Route>>(
      future: (() async =>
          (await GetIt.I<RoutesRepository>().getAllRoutes()).getOrElse(
            () {
              GetIt.I<Logger>().e("Can't get routes");

              return [];
            },
          ))(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var routes = snapshot.data ?? [];
          routes.sort(
            (left, right) {
              final dateComparation =
                  right.creationDate.compareTo(left.creationDate);
              if (dateComparation != 0) {
                return dateComparation;
              }

              return right.category.compareTo(left.category);
            },
          );
          final quarters =
              Set.unmodifiable(routes.map((e) => getQuarter(e.creationDate)));
          String previous = '';
          List<Widget> elements = [];

          for (int i = 0, routeIndex = 0;
              i < routes.length + quarters.length;
              i++) {
            if (previous != getQuarter(routes[routeIndex].creationDate)) {
              previous = getQuarter(routes[routeIndex].creationDate);

              elements.add(Text(
                previous,
                style: AppTheme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ));
            }
            final current = routeIndex;
            if (routeIndex < routes.length - 1) {
              routeIndex++;
            } else {
              routeIndex = 0;
            }

            elements.add(RouteCard(route: routes[current]));
          }

          return SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView.separated(
                  padding: const Pad(all: 16),
                  itemCount: routes.length + quarters.length,
                  itemBuilder: (context, index) => elements[index],
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                ),
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          GetIt.I<Logger>().e(snapshot.error);
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    );
  }

  String getQuarter(DateTime date) => DateFormat("yyyy ''QQQ").format(date);
}
