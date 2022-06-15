import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class RootPage extends StatelessWidget {
  static const routes = [RatingRouter(), RoutesRouter()];
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;
    final textTheme = AppTheme.of(context).textTheme;

    return AutoTabsScaffold(
      routes: routes,
      drawer: Drawer(
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return ListView(
              shrinkWrap: true,
              children: [
                ...state.maybeMap(
                  authorized: (value) => [
                    DrawerHeader(
                      decoration: BoxDecoration(color: colorTheme.primary),
                      padding: Pad.zero,
                      child: Material(
                        color: colorTheme.primary,
                        child: InkWell(
                          onTap: () =>
                              AutoRouter.of(context).push(const ProfileRoute()),
                          child: Padding(
                            padding: const Pad(all: 16, bottom: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '${value.activeUser.firstName} ${value.activeUser.lastName}',
                                  style: textTheme.title
                                      .copyWith(color: colorTheme.onPrimary),
                                ),
                                Text(
                                  '@${value.activeUser.username}',
                                  style: textTheme.subtitle2.copyWith(
                                    color:
                                        colorTheme.onPrimary.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  orElse: () => [],
                ),
                ListTile(
                  dense: true,
                  onTap: () =>
                      AutoRouter.of(context).push(const MyRoutesRoute()),
                  title: const Text("Загруженные трассы"),
                ),
                ListTile(
                  dense: true,
                  onTap: () =>
                      AutoRouter.of(context).push(const ExpiringAscentsRoute()),
                  title: const Text("Истекающие пролазы"),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: colorTheme.primary,
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
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
            ],
          ),
        );
      },
      builder: (context, child, animation) {
        return SafeArea(
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      extendBody: true,
      floatingActionButton: SpeedDial(
        backgroundColor: colorTheme.secondary,
        foregroundColor: colorTheme.onSecondary,
        // ignore: no-equal-arguments
        overlayColor: colorTheme.secondary,
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 8,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            label: "Трасса",
            child: const Icon(Icons.add),
            onTap: () => AutoRouter.of(context).push(const AddRouteRootRoute()),
          ),
          SpeedDialChild(
            label: "Соревнование",
            child: const Icon(Icons.add),
            onTap: () =>
                AutoRouter.of(context).push(const AddCompetitionRoute()),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void setActiveTab(BuildContext _, int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}
