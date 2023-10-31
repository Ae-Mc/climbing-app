import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? color;
  final double? value;

  const CustomProgressIndicator({super.key, this.color, this.value});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      valueColor: AlwaysStoppedAnimation(
        color ?? AppTheme.of(context).colorTheme.primary,
      ),
      value: value,
    );
  }
}
