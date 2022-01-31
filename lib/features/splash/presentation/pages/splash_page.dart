import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_state.dart';
import 'package:climbing_app/features/splash/presentation/widgets/initialization_indicator.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  void onInitialized(BuildContext _, SplashBlocSingleResult __) {
    GetIt.I.get<Logger>().d('Initialized');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) =>
          SplashBloc(GetIt.I.get())..add(const SplashBlocEventInit()),
      child: SingleResultBlocBuilder<SplashBloc, SplashBlocState,
          SplashBlocSingleResult>(
        onSingleResult: onInitialized,
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Box(
                color: AppTheme.of(context).colorTheme.backgroundVariant,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Spacer(),
                          Expanded(flex: 10, child: Assets.icons.logo.svg()),
                          const Spacer(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: InitializationIndicator(
                          isFailure: state is SplashBlocStateFailure,
                          callback: () => BlocProvider.of<SplashBloc>(context)
                              .add(const SplashBlocEventInit()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
