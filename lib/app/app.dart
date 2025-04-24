import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/bloc/app_theme_bloc.dart';
import 'package:climbing_app/features/competitions/presentation/bloc/competitions_bloc.dart';
import 'package:climbing_app/features/splash/data/repositories/startup_repository_impl.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:climbing_app/features/splash/presentation/bloc/splash_state.dart';
import 'package:climbing_app/features/splash/presentation/pages/splash_page.dart';
import 'package:climbing_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:climbing_app/features/routes/presentation/bloc/routes_bloc.dart';
import 'package:logger/logger.dart';

class SplashRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return const SplashPage();
  }

  @override
  Future<bool> popRoute() async {
    return false;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeBloc()),
        BlocProvider(create: (context) => GetIt.I<UserBloc>()),
        BlocProvider(
          create: (context) => SplashBloc(StartupRepositoryImpl(context)),
        ),
        BlocProvider(
          create: (_) =>
              GetIt.I<RoutesBloc>()..add(const RoutesBlocEvent.loadRoutes()),
        ),
        BlocProvider(create: (context) => GetIt.I<CompetitionsBloc>()),
      ],
      child: BlocBuilder<AppThemeBloc, AppTheme>(
        builder: (context, theme) {
          inputBorder({required Color color, double width = 1}) =>
              OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(
                    color: color,
                    width: width,
                  ));

          return BlocBuilder<SplashBloc, SplashState>(
            builder: (context, splashState) {
              late final RouterConfig<UrlState>? routerConfig;
              switch (splashState) {
                case SplashStateLoaded():
                  routerConfig = GetIt.I<AppRouter>().config(
                    deepLinkBuilder: (deepLink) {
                      if (deepLink.isValid) {
                        final matchedRoutes =
                            deepLink.matches.map((e) => e.name);
                        if (matchedRoutes.contains(ForgotPasswordRoute.name)) {
                          return DeepLink([
                            const RoutesRoute(),
                            SignInRoute(onSuccessSignIn: () => {}),
                            const ForgotPasswordRoute()
                          ]);
                        }

                        if (matchedRoutes.contains(ResetPasswordRoute.name)) {
                          final match = deepLink.matches.firstWhere((element) =>
                              element.name == ResetPasswordRoute.name);
                          GetIt.I<Logger>().d(match);
                          late final String? token;
                          try {
                            token = match.params.getString("token", "");
                          } on FlutterError {
                            token = null;
                          }
                          return DeepLink([
                            const RoutesRoute(),
                            SignInRoute(onSuccessSignIn: () => {}),
                            ResetPasswordRoute(token: token),
                          ]);
                        }
                      }
                      return DeepLink.single(const RoutesRoute());
                    },
                  );
                case _:
                  routerConfig = null;
              }
              return MaterialApp.router(
                title: "Скалолазание ИТМО",
                scrollBehavior: const ScrollBehavior().copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse
                  },
                ),
                routerConfig: routerConfig,
                routerDelegate:
                    routerConfig == null ? SplashRouterDelegate() : null,
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  inputDecorationTheme: InputDecorationTheme(
                    enabledBorder:
                        inputBorder(color: theme.colorTheme.unselected),
                    focusedBorder:
                        inputBorder(color: theme.colorTheme.primary, width: 2),
                    errorBorder: inputBorder(color: theme.colorTheme.error),
                    focusedErrorBorder:
                        inputBorder(color: theme.colorTheme.error, width: 2),
                    contentPadding: const Pad(left: 16, vertical: 14.5),
                  ),
                  cardTheme: CardTheme(
                    elevation: 8,
                    color: theme.colorTheme.surface,
                    margin: Pad.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  chipTheme: ChipThemeData(
                    backgroundColor: theme.colorTheme.secondary,
                    padding: const Pad(horizontal: 11, vertical: 0),
                    labelPadding: Pad.zero,
                    labelStyle: theme.textTheme.chip,
                  ),
                  colorScheme: const ColorScheme.light().copyWith(
                    brightness: theme.colorTheme.brightness,
                    error: theme.colorTheme.error,
                    onError: theme.colorTheme.onError,
                    onPrimary: theme.colorTheme.onPrimary,
                    primary: theme.colorTheme.primary,
                    secondary: theme.colorTheme.secondary,
                    surface: theme.colorTheme.surface,
                    onSurface: theme.colorTheme.onBackground,
                  ),
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith(
                        (states) => states.contains(WidgetState.disabled)
                            ? theme.colorTheme.unselected
                            : theme.colorTheme.primary,
                      ),
                      elevation: const WidgetStatePropertyAll(8),
                      minimumSize: const WidgetStatePropertyAll(Size.zero),
                      padding: const WidgetStatePropertyAll(
                        Pad(horizontal: 64, vertical: 16),
                      ),
                      shape: const WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      textStyle: WidgetStatePropertyAll(theme.textTheme.button),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                  fontFamily: theme.textTheme.fontFamily,
                  iconTheme: IconThemeData(color: theme.colorTheme.primary),
                  scaffoldBackgroundColor: theme.colorTheme.background,
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        theme.colorTheme.secondaryVariant,
                      ),
                      padding: const WidgetStatePropertyAll(Pad.zero),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle:
                          WidgetStatePropertyAll(theme.textTheme.subtitle2),
                    ),
                  ),
                  textTheme: TextTheme(
                    bodyLarge: theme.textTheme.body1Regular,
                    titleMedium: theme.textTheme.subtitle1,
                    titleSmall: theme.textTheme.subtitle2,
                  ),
                  useMaterial3: false,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
