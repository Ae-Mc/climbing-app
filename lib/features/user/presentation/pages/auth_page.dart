import 'dart:async';
import 'dart:math';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  // ignore: avoid-late-keyword
  late Timer timer;

  static Random random = Random();
  final List<Color> colors = List.generate(24, (index) => getRandomColor());
  bool paused = false;

  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 40), (timer) => update());
    GetIt.I<Logger>().d(colors);
    super.initState();
  }

  static Color getRandomColor() =>
      Color((0x7F << 24) + random.nextInt(1 << 24));

  void update() {
    if (!paused) {
      // ignore: avoid-ignoring-return-values
      colors.removeLast();
      colors.insert(0, getRandomColor());
      setState(() => []);
    }
  }

  void onTap() {
    paused = !paused;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: onTap,
        child: Recursive(colors: colors),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}

// ignore: prefer-single-widget-per-file
class Recursive extends StatelessWidget {
  final List<Color> colors;

  const Recursive({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const Pad(all: 16),
      color: colors[0],
      child: colors.length > 1
          ? Recursive(colors: colors.getRange(1, colors.length).toList())
          : Container(color: colors[0], width: 16),
    );
  }
}
