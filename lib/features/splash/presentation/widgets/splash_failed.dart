import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_event.dart';

class SplashFailed extends StatelessWidget {
  const SplashFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Assets.icons.logo.svg(),
        SizedBox(
          height: 48,
          width: 48,
          child: FloatingActionButton.small(
            onPressed: () => BlocProvider.of<SplashBloc>(context)
                .add(const SplashEvent.retryInitialization()),
            child: const Icon(Icons.replay),
            backgroundColor: AppTheme.of(context).colorTheme.primary,
            foregroundColor: AppTheme.of(context).colorTheme.onPrimary,
          ),
        ),
      ],
    );
  }
}
