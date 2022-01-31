import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:flutter/material.dart';

class InitializationIndicator extends StatelessWidget {
  final bool isFailure;
  final void Function() callback;
  const InitializationIndicator({
    Key? key,
    required this.isFailure,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: isFailure
          ? IconButton(
              onPressed: callback,
              icon: Icon(
                Icons.replay,
                color: AppTheme.of(context).colorTheme.onBackgroundVariant,
              ),
            )
          : CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                AppTheme.of(context).colorTheme.onBackgroundVariant,
              ),
            ),
    );
  }
}
