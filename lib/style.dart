import 'package:flutter/material.dart';

class Style {
  static const MaterialColor primarySwatch = Colors.green;
  static const Color backgroundColor = Colors.white;

  static const TextTheme textTheme = TextTheme();
  static final ThemeData themeData = ThemeData(
    primarySwatch: Colors.green,
    backgroundColor: backgroundColor,
    dividerColor: Colors.black,
  );

  Style._();
}
