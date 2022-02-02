import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final void Function() onPressed;

  const RetryButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: AppTheme.of(context).colorTheme.button,
      child: FractionallySizedBox(
        heightFactor: 0.6,
        widthFactor: 0.6,
        child: FittedBox(
          child: Icon(
            Icons.replay,
            color: AppTheme.of(context).colorTheme.onBackgroundVariant,
          ),
        ),
      ),
    );
  }
}
