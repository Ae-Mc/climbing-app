import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/router/guards/auth_guard.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RootPage extends StatelessWidget {
  static const routes = [RatingRouter(), RoutesRouter(), UserRouter()];
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return SafeArea(
      child: AutoTabsScaffold(
        routes: routes,
        bottomNavigationBuilder: (context, tabsRouter) {
          return BottomNavigationBar(
            backgroundColor: colorTheme.primary,
            currentIndex: tabsRouter.activeIndex,
            elevation: 0,
            iconSize: 32,
            onTap: (index) => setActiveTab(context, index, tabsRouter),
            selectedItemColor: colorTheme.onPrimary,
            unselectedItemColor: colorTheme.unselectedNavBar,
            items: const [
              BottomNavigationBarItem(
                label: "Рейтинг",
                icon: Icon(Icons.trending_up_rounded),
              ),
              BottomNavigationBarItem(
                label: "Трассы",
                icon: Icon(Icons.ballot_outlined),
              ),
              BottomNavigationBarItem(
                label: "Профиль",
                icon: Icon(Icons.person),
              ),
            ],
          );
        },
        builder: (context, child, animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              AutoRouter.of(context).navigate(const AddRouteRootRoute()),
          foregroundColor: colorTheme.onSecondary,
          backgroundColor: colorTheme.secondary,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void setActiveTab(BuildContext context, int index, TabsRouter tabsRouter) {
    if (routes[index] is! UserRouter ||
        GetIt.I<AuthGuard>().isAuthenticated()) {
      tabsRouter.setActiveIndex(index);
    } else {
      // ignore: avoid-ignoring-return-values
      AutoRouter.of(context).push(
        SignInRoute(onSuccessSignIn: () => tabsRouter.setActiveIndex(index)),
      );
    }
  }
}
