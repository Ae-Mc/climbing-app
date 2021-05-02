import 'package:flutter/material.dart';

class Style {
  final Color primaryColor = Color(0xFF385790);

  TextTheme get textTheme => TextTheme();

  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          onSecondary: Colors.white,
          primary: primaryColor,
          secondary: Colors.blue,
        ),
        dividerColor: Colors.black,
      );

  Style();
}
