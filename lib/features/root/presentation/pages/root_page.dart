import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        RoutesRouter(),
        AuthRouter(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: AppTheme.of(context).colorTheme.onBackground,
                spreadRadius: -2,
              ),
            ],
            color: AppTheme.of(context).colorTheme.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            currentIndex: tabsRouter.activeIndex,
            elevation: 0,
            iconSize: 32,
            onTap: tabsRouter.setActiveIndex,
            selectedItemColor: AppTheme.of(context).colorTheme.primary,
            unselectedItemColor:
                AppTheme.of(context).colorTheme.unselectedAppBar,
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
    );
  }
}
