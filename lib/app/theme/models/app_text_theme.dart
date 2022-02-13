import 'package:flutter/material.dart';

@immutable
abstract class AppTextTheme {
  String get fontFamily;

  TextStyle get body1Regular;
}

@immutable
class BaseTextTheme implements AppTextTheme {
  const BaseTextTheme();

  @override
  String get fontFamily => 'Rubik';

  @override
  TextStyle get body1Regular => const TextStyle(
        fontSize: 16,
        letterSpacing: 0.5,
      );
}
