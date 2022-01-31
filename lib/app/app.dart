import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/app_theme_provider.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/bloc/app_theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final router = GetIt.I.get<AppRouter>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      create: (context) => AppThemeBloc(),
      child: BlocBuilder<AppThemeBloc, AppTheme>(
        builder: (context, state) {
          return AppThemeProvider(
            theme: state,
            child: MaterialApp.router(
              routeInformationParser: router.defaultRouteParser(),
              routerDelegate: router.delegate(),
              theme: ThemeData(
                colorScheme: const ColorScheme.light().copyWith(
                  background: state.colorTheme.background,
                  brightness: state.colorTheme.brightness,
                  primary: state.colorTheme.primary,
                ),
                textTheme: TextTheme(bodyText1: state.textTheme.body1Regular),
              ),
            ),
          );
        },
      ),
    );
  }
}
