import 'dart:async';
import 'dart:math';

import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late Timer timer;
  bool paused = false;
  final Random random = Random();

  @override
  void initState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 4), (timer) => update());
    super.initState();
  }

  void update() {
    if (!paused) {
      setState(() => []);
    }
  }

  void onTap() {
    paused = !paused;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: onTap,
          child: Recursive(
            depth: 0,
            random: random,
          ),
        ),
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
  final int depth;
  final Random random;

  const Recursive({Key? key, required this.depth, required this.random})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const Pad(all: 16),
      color: Color((0x7F << 24) + random.nextInt(0xFFFFFF)),
      child: depth < 24
          ? Recursive(
              depth: depth + 1,
              random: random,
            )
          : const SizedBox(
              height: 16,
              width: 16,
            ),
    );
  }
}
