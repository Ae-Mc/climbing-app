import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_card.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:intl/intl.dart';

class RoutesList extends StatelessWidget {
  final List<Route> sortedRoutes;
  final Set<String> quarters;

  RoutesList({Key? key, required List<Route> routes})
      : sortedRoutes = List.from(routes)
          ..sort(
            (left, right) {
              final dateComparation =
                  right.creationDate.compareTo(left.creationDate);
              if (dateComparation != 0) {
                return dateComparation;
              }

              return right.category.compareTo(left.category);
            },
          ),
        quarters =
            Set.unmodifiable(routes.map((e) => getQuarter(e.creationDate))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    String previous = '';
    List<Widget> elements = [];

    for (int i = 0; i < sortedRoutes.length; i++) {
      if (previous != getQuarter(sortedRoutes[i].creationDate)) {
        previous = getQuarter(sortedRoutes[i].creationDate);

        elements.add(Text(
          previous,
          style: AppTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ));
      }
      elements.add(RouteCard(route: sortedRoutes[i]));
    }

    return ListView.separated(
      padding: const Pad(all: 16),
      itemCount: elements.length,
      itemBuilder: (context, index) => elements[index],
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  static String getQuarter(DateTime date) =>
      DateFormat("yyyy ''QQQ").format(date);
}
