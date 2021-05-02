import 'package:flutter/material.dart';
import 'package:itmo_climbing/theme/style.dart';

extension CustomColorScheme on ColorScheme {
  List<Color> get indicatorColors => [
        Style().primaryColor,
        Colors.green,
        Colors.redAccent,
      ];
}
