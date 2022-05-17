import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_card.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:intl/intl.dart';

class RoutesList extends StatelessWidget {
  final List<Route> routes;
  final Set<String> quarters;

  RoutesList({Key? key, required this.routes})
      : quarters =
            Set.unmodifiable(routes.map((e) => getQuarter(e.creationDate))),
        super(key: key) {
    routes.sort(
      (left, right) {
        final dateComparation = right.creationDate.compareTo(left.creationDate);
        if (dateComparation != 0) {
          return dateComparation;
        }

        return right.category.compareTo(left.category);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String previous = '';
    List<Widget> elements = [];

    for (int i = 0; i < routes.length; i++) {
      if (previous != getQuarter(routes[i].creationDate)) {
        previous = getQuarter(routes[i].creationDate);

        elements.add(Text(
          previous,
          style: AppTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ));
      }
      elements.add(RouteCard(route: routes[i]));
    }

    return ListView.separated(
      padding: const Pad(all: 16, bottom: 80),
      itemCount: elements.length,
      itemBuilder: (context, index) => elements[index],
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  static String getQuarter(DateTime date) =>
      DateFormat("yyyy ''QQQ").format(date);
}
