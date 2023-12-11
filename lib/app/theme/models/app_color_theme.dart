import 'package:climbing_app/app/theme/models/app_pallete.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AppColorTheme {
  Brightness get brightness;
  Color get ascentActual;
  Color get ascentTop5;
  Color get background;
  Color get bronze;
  Color get dangerousAction;
  Color get error;
  Color get gold;
  Color get onBackground;
  Color get onError;
  Color get onPrimary;
  Color get onSecondary;
  Color get onSuccess;
  Color get primary;
  Color get routeEasy;
  Color get routeMedium;
  Color get routeHard;
  Color get secondary;
  Color get secondaryVariant;
  Color get silver;
  Color get success;
  Color get surface;
  Color get unselected;
  Color get unselectedVariant;
  Color get unselectedNavBar;
}

@immutable
class LightColorTheme implements AppColorTheme {
  const LightColorTheme();

  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get ascentActual => AppPallete.green;
  @override
  Color get ascentTop5 => AppPallete.red;
  @override
  Color get background => AppPallete.white;
  @override
  Color get bronze => AppPallete.bronze;
  @override
  Color get dangerousAction => AppPallete.red;
  @override
  Color get error => AppPallete.red;
  @override
  Color get gold => AppPallete.gold;
  @override
  Color get onBackground => AppPallete.subBlack2;
  @override
  Color get onError => AppPallete.white;
  @override
  Color get onPrimary => AppPallete.white;
  @override
  Color get onSecondary => AppPallete.white;
  @override
  Color get onSuccess => AppPallete.black;
  @override
  Color get primary => AppPallete.bluegrey;
  @override
  Color get routeEasy => AppPallete.green;
  @override
  Color get routeMedium => AppPallete.orange;
  @override
  Color get routeHard => AppPallete.red;
  @override
  Color get secondary => AppPallete.subBlack;
  @override
  Color get secondaryVariant => AppPallete.darkgrey;
  @override
  Color get silver => AppPallete.silver;
  @override
  Color get success => AppPallete.lightGreen;
  @override
  Color get surface => AppPallete.white;
  @override
  Color get unselected => AppPallete.grey;
  @override
  Color get unselectedVariant => AppPallete.greyVariant;
  @override
  Color get unselectedNavBar => AppPallete.white50;
}
