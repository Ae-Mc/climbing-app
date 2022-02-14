import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/route.dart';
import 'package:climbing_app/features/routes/domain/repositories/routes_repository.dart';
import 'package:climbing_app/features/routes/presentation/widgets/route_card.dart';
import 'package:flutter/material.dart' hide Route;
import 'package:get_it/get_it.dart';
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
          final routes = snapshot.data ?? [];

          return SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView.separated(
                  padding: const Pad(all: 16),
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    return RouteCard(route: routes[index]);
                  },
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
}
