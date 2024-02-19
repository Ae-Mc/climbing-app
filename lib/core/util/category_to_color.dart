import 'package:climbing_app/app/theme/models/app_color_theme.dart';
import 'package:climbing_app/features/routes/domain/entities/category.dart';
import 'package:flutter/material.dart';

Color categoryToColor(Category category, AppColorTheme colorTheme) {
  if (category < Category.sixAPlus) {
    return colorTheme.routeEasy;
  }
  if (category < Category.sevenAPlus) {
    return colorTheme.routeMedium;
  }

  return colorTheme.routeHard;
}
