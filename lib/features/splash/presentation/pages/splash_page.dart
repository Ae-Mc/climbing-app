import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/core/util/failure_to_text.dart';
import 'package:climbing_app/core/widgets/custom_progress_indicator.dart';
import 'package:climbing_app/core/widgets/unexpected_behavior.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:climbing_app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_result_bloc/single_result_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(const SplashEvent.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        final colorTheme = AppTheme.of(context).colorTheme;

        return Scaffold(
          backgroundColor: colorTheme.primary,
          body: SafeArea(
            child: SingleResultBlocBuilder<SplashBloc, SplashState,
                SplashSingleResult>(
              onSingleResult: onSingleResult,
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Assets.icons.logo.svg(),
                  Center(
                    child: state.when<Widget>(
                      loading: () => SizedBox(
                        height: 48,
                        width: 48,
                        child: CustomProgressIndicator(
                          color: AppTheme.of(context).colorTheme.onPrimary,
                        ),
                      ),
                      failure: (_) => SizedBox(
                        height: 48,
                        width: 48,
                        child: FloatingActionButton.small(
                          onPressed: () => BlocProvider.of<SplashBloc>(context)
                              .add(const SplashEvent.retryInitialization()),
                          backgroundColor:
                              AppTheme.of(context).colorTheme.primary,
                          foregroundColor:
                              AppTheme.of(context).colorTheme.onPrimary,
                          child: const Icon(Icons.replay),
                        ),
                      ),
                      loaded: () => const UnexpectedBehavior(),
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

  void onSingleResult(BuildContext context, SplashSingleResult singleResult) {
    final customToast = CustomToast(context);

    // ignore: avoid-ignoring-return-values
    singleResult.when<void>(
      failure: (failure) =>
          customToast.showTextFailureToast(failureToText(failure)),
    );
  }
}
