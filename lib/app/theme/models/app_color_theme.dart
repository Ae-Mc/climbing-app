import 'package:climbing_app/app/theme/models/app_pallete.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppColorTheme {
  Brightness get brightness;
  Color get accent;
  Color get background;
  Color get backgroundVariant;
  Color get button;
  Color get error;
  Color get onBackground;
  Color get onBackgroundVariant;
  Color get onError;
  Color get onPrimary;
  Color get primary;
  Color get routeEasy;
  Color get routeMedium;
  Color get routeHard;
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
  Color get error => AppPallete.red;

  @override
  Color get onBackground => AppPallete.subBlack;

  @override
  Color get onBackgroundVariant => AppPallete.white;

  @override
  Color get onError => AppPallete.white;

  @override
  Color get onPrimary => AppPallete.white;

  @override
  Color get primary => AppPallete.bluegrey;

  @override
  Color get routeEasy => AppPallete.green;

  @override
  Color get routeMedium => AppPallete.orange;

  @override
  Color get routeHard => AppPallete.red;

  @override
  Color get unselectedAppBar => AppPallete.grey;
}
