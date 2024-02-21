import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isLoaded;
  final void Function() onPressed;
  final Color? color;

  const SubmitButton({
    super.key,
    required this.text,
    this.isActive = true,
    required this.isLoaded,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoaded && isActive ? onPressed : null,
      style: ButtonStyle(
        backgroundColor: color == null
            ? null
            : MaterialStateProperty.resolveWith((states) {
                for (final state in states) {
                  if (state == MaterialState.disabled) {
                    return AppTheme.of(context).colorTheme.unselected;
                  }
                }
                return color;
              }),
      ),
      child: isLoaded ? Text(text) : const CustomProgressIndicator(),
    );
  }
}
