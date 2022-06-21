import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:climbing_app/app/router/app_router.dart';
import 'package:climbing_app/app/theme/bloc/app_theme.dart';
import 'package:climbing_app/app/theme/bloc/app_theme_bloc.dart';
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

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
      ],
      child: BlocBuilder<AppThemeBloc, AppTheme>(
        builder: (context, theme) => MaterialApp(
          title: "Скалолазание ИТМО",
          scrollBehavior: const ScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          ),
          home: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, splashState) => splashState.maybeWhen(
              loaded: () => Router(
                backButtonDispatcher: RootBackButtonDispatcher(),
                routerDelegate: GetIt.I<AppRouter>().delegate(),
                routeInformationParser:
                    GetIt.I<AppRouter>().defaultRouteParser(),
                routeInformationProvider:
                    GetIt.I<AppRouter>().routeInfoProvider(),
              ),
              orElse: () => const SplashPage(),
            ),
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
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
              background: theme.colorTheme.background,
              brightness: theme.colorTheme.brightness,
              onPrimary: theme.colorTheme.onPrimary,
              primary: theme.colorTheme.primary,
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => states.contains(MaterialState.disabled)
                      ? theme.colorTheme.unselected
                      : theme.colorTheme.primary,
                ),
                elevation: MaterialStateProperty.all(8),
                minimumSize: MaterialStateProperty.all(Size.zero),
                padding: MaterialStateProperty.all(
                  const Pad(horizontal: 64, vertical: 16),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                textStyle: MaterialStateProperty.all(theme.textTheme.button),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            fontFamily: theme.textTheme.fontFamily,
            iconTheme: IconThemeData(color: theme.colorTheme.primary),
            scaffoldBackgroundColor: theme.colorTheme.background,
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                  theme.colorTheme.secondaryVariant,
                ),
                padding: MaterialStateProperty.all(Pad.zero),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textStyle: MaterialStateProperty.all(theme.textTheme.subtitle2),
              ),
            ),
            textTheme: TextTheme(
              bodyText1: theme.textTheme.body1Regular,
              subtitle1: theme.textTheme.subtitle1,
              subtitle2: theme.textTheme.subtitle2,
            ),
          ),
        ),
      ),
    );
  }
}
