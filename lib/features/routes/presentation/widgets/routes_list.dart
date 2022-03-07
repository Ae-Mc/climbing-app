import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_card.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:intl/intl.dart';

class RoutesList extends StatelessWidget {
  final List<Route> routes;

  const RoutesList({Key? key, required this.routes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    routes.sort(
      (left, right) {
        final dateComparation = right.creationDate.compareTo(left.creationDate);
        if (dateComparation != 0) {
          return dateComparation;
        }

        return right.category.compareTo(left.category);
      },
    );
    final quarters = Set.unmodifiable(
      routes.map((e) => getQuarter(e.creationDate)),
    );
    String previous = '';
    List<Widget> elements = [];

    for (int i = 0, routeIndex = 0; i < routes.length + quarters.length; i++) {
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

    return ListView.separated(
      padding: const Pad(all: 16, bottom: 80),
      itemCount: elements.length,
      itemBuilder: (context, index) => elements[index],
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  String getQuarter(DateTime date) => DateFormat("yyyy ''QQQ").format(date);
}
