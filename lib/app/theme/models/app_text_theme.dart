import 'package:flutter/material.dart';

@immutable
abstract class AppTextTheme {
  TextStyle get body1Regular;
}

@immutable
class BaseTextTheme implements AppTextTheme {
  const BaseTextTheme();

  @override
  TextStyle get body1Regular => const TextStyle(
        fontSize: 16,
        letterSpacing: 0.5,
      );
}
