import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/arch/custom_toast/custom_toast.dart';
import 'package:climbing_app/arch/single_result_bloc/single_result_bloc_builder.dart';
import 'package:climbing_app/core/widgets/unexpected_behavior.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_event.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:climbing_app/features/splash/presentation/widgets/splash_failed.dart';
import 'package:climbing_app/features/splash/presentation/widgets/splash_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Expanded(
                  flex: 3,
                  child: SingleResultBlocBuilder<SplashBloc, SplashState,
                      SplashSingleResult>(
                    onSingleResult: onSingleResult,
                    builder: (context, state) => state.when(
                      loading: () => const SplashLoading(),
                      failure: (_) => const SplashFailed(),
                      loaded: () => const UnexpectedBehavior(),
                    ),
                  ),
                ),
                const Spacer(),
              ],
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
      failure: (failure) => failure.when(
        connectionFailure: () =>
            customToast.showTextFailureToast("Ошибка соединения"),
        serverFailure: (statusCode) => customToast.showTextFailureToast(
          "Произошла ошибка на сервере. Код ошибки: $statusCode",
        ),
        unknownFailure: () => customToast.showTextFailureToast(
          'Произошла неизвестная ошибка. Свяжитесь с разработчиком',
        ),
      ),
    );
  }
}
