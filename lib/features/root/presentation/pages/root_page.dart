import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsScaffold(
        routes: const [
          RoutesRouter(),
          AuthRouter(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) {
          return BottomAppBar(
            color: AppTheme.of(context).colorTheme.primary,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              currentIndex: tabsRouter.activeIndex,
              elevation: 0,
              iconSize: 32,
              onTap: tabsRouter.setActiveIndex,
              selectedItemColor: AppTheme.of(context).colorTheme.onPrimary,
              unselectedItemColor:
                  AppTheme.of(context).colorTheme.unselectedNavBar,
              items: const [
                BottomNavigationBarItem(
                  label: "Трассы",
                  icon: Icon(Icons.ballot_outlined),
                ),
                BottomNavigationBarItem(
                  label: "Профиль",
                  icon: Icon(Icons.person),
                ),
              ],
            ),
          );
        },
        builder: (context, child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () => GetIt.I<Logger>().d('Add new route'),
          child: const Icon(Icons.add),
          foregroundColor: AppTheme.of(context).colorTheme.onSecondary,
          backgroundColor: AppTheme.of(context).colorTheme.secondary,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
