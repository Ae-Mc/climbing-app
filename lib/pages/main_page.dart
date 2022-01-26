import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/router.gr.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HistoryRouter(),
        HomeRouter(),
        GuideRouter(),
      ],
      appBarBuilder: (_, tabsRouter) => AppBar(
        title: Text(S.current.ITMOClimbing),
        leading: const AutoBackButton(),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
      ),
      bottomNavigationBuilder: (context, router) => BottomNavigationBar(
        iconSize: 32,
        currentIndex: router.activeIndex,
        onTap: (newIndex) => router.setActiveIndex(newIndex),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.history),
            label: S.current.History,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: S.current.Home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.menu_book_rounded),
            label: S.current.Guide,
          ),
        ],
      ),
    );
  }
}
