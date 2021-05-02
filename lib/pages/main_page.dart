import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/router.gr.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: [
        HistoryRouter(),
        HomeRouter(),
        GuideRouter(),
      ],
      appBarBuilder: (_, tabsRouter) => AppBar(
        title: Text(S.current.ITMOClimbing),
        leading: AutoBackButton(),
        automaticallyImplyLeading: true,
        titleSpacing: 0,
      ),
      bottomNavigationBuilder: (context, router) => BottomNavigationBar(
        iconSize: 32,
        currentIndex: router.activeIndex,
        onTap: (newIndex) => router.setActiveIndex(newIndex),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: S.current.History,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: S.current.Home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: S.current.Guide,
          ),
        ],
      ),
    );
  }
}
