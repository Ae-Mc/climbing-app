import 'package:flutter/material.dart';
import 'package:traverse/generated/l10n.dart';
import 'package:traverse/screens/history/history_screen.dart';
import 'package:traverse/screens/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.Traverse),
        actions: [
          /*
          PopupMenuButton( // TODO
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(S.current.Settings),
              ),
              PopupMenuItem(
                child: Text(S.current.Export),
              ),
            ],
          ),*/
        ],
        bottom: TabBar(
          labelPadding: EdgeInsets.all(8),
          controller: _tabController,
          tabs: [
            Text(S.current.Home),
            Text(S.current.History),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                HomeScreen(),
                HistoryScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
