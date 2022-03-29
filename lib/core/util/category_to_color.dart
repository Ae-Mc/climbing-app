import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:flutter/material.dart';

Color categoryToColor(Category category, AppColorTheme colorTheme) {
  if (category.index < Category('6a+').index) {
    return colorTheme.routeEasy;
  }
  if (category.index < Category('7a+').index) {
    return colorTheme.routeMedium;
  }

  return colorTheme.routeHard;
}
