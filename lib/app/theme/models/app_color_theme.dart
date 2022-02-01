import 'package:climbing_app/app/theme/models/app_pallete.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppColorTheme {
  Brightness get brightness;
  Color get accent;
  Color get background;
  Color get backgroundVariant;
  Color get button;
  Color get onBackgroundVariant;
  Color get onPrimary;
  Color get primary;
  Color get unselectedAppBar;
}

@immutable
class LightColorTheme implements AppColorTheme {
  const LightColorTheme();

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get accent => AppPallete.bluegrey;

  @override
  Color get background => AppPallete.white;

  @override
  Color get backgroundVariant => AppPallete.bluegrey;

  @override
  Color get button => AppPallete.darkbluegrey;

  @override
  Color get onBackgroundVariant => AppPallete.white;

  @override
  Color get onPrimary => AppPallete.white;

  @override
  Color get primary => AppPallete.bluegrey;

  @override
  Color get unselectedAppBar => AppPallete.white50;
}
