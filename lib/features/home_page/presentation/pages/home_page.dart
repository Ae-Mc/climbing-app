import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/home_page/presentation/widgets/year_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).colorTheme.primary,
        title: const Text("Главная"),
        actions: [
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.more_vert_rounded),
            splashRadius: 24,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView.separated(
              padding: const Pad(all: 16),
              itemCount: 4,
              itemBuilder: (context, index) => YearWidget(year: 2022 - index),
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 16,
        child: BottomNavigationBar(
          backgroundColor: AppTheme.of(context).colorTheme.primary,
          iconSize: 32,
          selectedItemColor: AppTheme.of(context).colorTheme.onPrimary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: AppTheme.of(context).colorTheme.unselectedAppBar,
          onTap: bottomNavBarOnTap,
          items: const [
            BottomNavigationBarItem(label: "Главная", icon: Icon(Icons.home)),
            BottomNavigationBarItem(
              label: "Профиль",
              icon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }

  void bottomNavBarOnTap(int index) {
  }
}
