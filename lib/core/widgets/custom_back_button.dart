import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final void Function(BuildContext context) onPressed;
  static const double iconSize = 48;

  const CustomBackButton({
    super.key,
    this.onPressed = defaultOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorTheme = AppTheme.of(context).colorTheme;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(colorTheme.secondary),
        foregroundColor: WidgetStatePropertyAll(colorTheme.background),
        padding: const WidgetStatePropertyAll(Pad.zero),
        shape: const WidgetStatePropertyAll(CircleBorder()),
      ),
      onPressed: () => onPressed(context),
      child: Icon(Icons.chevron_left,
          color: colorTheme.background, size: iconSize),
    );
  }

  static void defaultOnPressed(BuildContext context) =>
      // ignore: avoid-ignoring-return-values
      AutoRouter.of(context).maybePop();
}
