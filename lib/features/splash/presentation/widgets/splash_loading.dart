import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.icons.logo.svg(),
        SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(
              AppTheme.of(context).colorTheme.onPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
