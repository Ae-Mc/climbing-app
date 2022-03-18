import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc_state.dart';
import 'package:climbing_app/features/splash/presentation/widgets/retry_button.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(const SplashBlocEvent.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashBlocState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Box(
              color: AppTheme.of(context).colorTheme.primary,
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
                    child: FractionallySizedBox(
                      heightFactor: 0.3,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: state.maybeWhen(
                          orElse: () => CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation(
                              AppTheme.of(context).colorTheme.onPrimary,
                            ),
                          ),
                          failure: (_) => RetryButton(
                            onPressed: () =>
                                BlocProvider.of<SplashBloc>(context)
                                    .add(const SplashBlocEventInit()),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
