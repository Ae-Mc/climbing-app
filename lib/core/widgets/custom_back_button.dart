import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final double size;
  final void Function(BuildContext context) onPressed;

  const CustomBackButton({
    Key? key,
    this.size = 32,
    this.onPressed = defaultOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          AppTheme.of(context).colorTheme.onBackground,
        ),
        foregroundColor: MaterialStateProperty.all(
          AppTheme.of(context).colorTheme.background,
        ),
        padding: MaterialStateProperty.all(Pad.zero),
        shape: MaterialStateProperty.all(const CircleBorder()),
      ),
      onPressed: () => onPressed(context),
      child: Icon(
        Icons.chevron_left,
        color: AppTheme.of(context).colorTheme.background,
        size: size,
      ),
    );
  }

  static void defaultOnPressed(BuildContext context) {
    // ignore: avoid-ignoring-return-values
    AutoRouter.of(context).pop();
  }
}
