import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_card.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:intl/intl.dart';

class RoutesList extends StatelessWidget {
  final List<Route> sortedRoutes;
  final Set<String> quarters;
  final Widget Function(BuildContext context)? headerSliverBuilder;

  RoutesList({Key? key, required List<Route> routes, this.headerSliverBuilder})
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
    List<Widget> elements = [];

    String previous = '';
    for (int i = 0; i < sortedRoutes.length; i++) {
      if (previous != getQuarter(sortedRoutes[i].creationDate)) {
        previous = getQuarter(sortedRoutes[i].creationDate);

        elements.add(Text(
          previous,
          style: AppTheme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ));
        elements.add(const SizedBox(height: 16));
      }
      elements.add(RouteCard(route: sortedRoutes[i]));
      elements.add(const SizedBox(height: 16));
    }

    return CustomScrollView(
      slivers: [
        if (headerSliverBuilder != null) headerSliverBuilder!(context),
        SliverPadding(
          padding: const Pad(all: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: elements.length,
              (context, index) => elements[index],
            ),
          ),
        ),
      ],
    );
  }

  static String getQuarter(DateTime date) =>
      DateFormat("yyyy ''QQQ").format(date);
}
