import 'package:climbing_app/app/theme/models/app_pallete.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppColorTheme {
  Brightness get brightness;
  Color get primary;
  Color get accent;
  Color get background;
  Color get backgroundVariant;
  Color get onBackgroundVariant;
  Color get iconPrimary;
}

@immutable
class LightColorTheme implements AppColorTheme {
  const LightColorTheme();

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get accent => AppPallete.greyblue;

  @override
  Color get background => AppPallete.white;

  @override
  Color get backgroundVariant => AppPallete.greyblue;

  @override
  Color get onBackgroundVariant => AppPallete.white;

  @override
  Color get iconPrimary => AppPallete.greyblue;

  @override
  Color get primary => AppPallete.black;
}
