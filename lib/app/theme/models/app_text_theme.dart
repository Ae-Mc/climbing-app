import 'package:flutter/material.dart';

@immutable
abstract class AppTextTheme {
  String get fontFamily;

  TextStyle get body1Regular;
  TextStyle get body2Regular;
  TextStyle get button;
  TextStyle get chip;
  TextStyle get headline2;
  TextStyle get subtitle1;
  TextStyle get subtitle2;
  TextStyle get title;
}

@immutable
class BaseTextTheme implements AppTextTheme {
  const BaseTextTheme();

  @override
  String get fontFamily => 'Rubik';

  @override
  TextStyle get body1Regular => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.5,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get body2Regular => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get button => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get chip => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get headline2 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get subtitle1 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get subtitle2 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      );

  @override
  TextStyle get title => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.5,
        overflow: TextOverflow.ellipsis,
      );
}
