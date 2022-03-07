import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
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
    final router = GetIt.I<AppRouter>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      create: (context) => AppThemeBloc(),
      child: BlocBuilder<AppThemeBloc, AppTheme>(
        builder: (context, theme) {
          return AppThemeProvider(
            theme: theme,
            child: MaterialApp.router(
              title: "Скалолазание ИТМО",
              routeInformationParser: router.defaultRouteParser(),
              routerDelegate: router.delegate(),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                cardTheme: CardTheme(
                  elevation: 8,
                  color: theme.colorTheme.surface,
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
                    elevation: MaterialStateProperty.all(8),
                    padding: MaterialStateProperty.all(
                      const Pad(horizontal: 64, vertical: 16),
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    ),
                    textStyle:
                        MaterialStateProperty.all(theme.textTheme.button),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStateProperty.all(Size.zero),
                  ),
                ),
                fontFamily: theme.textTheme.fontFamily,
                iconTheme: IconThemeData(color: theme.colorTheme.primary),
                textButtonTheme: TextButtonThemeData(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(
                      theme.colorTheme.secondaryVariant,
                    ),
                    padding: MaterialStateProperty.all(Pad.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    textStyle:
                        MaterialStateProperty.all(theme.textTheme.caption),
                  ),
                ),
                textTheme: TextTheme(
                  bodyText1: theme.textTheme.body1Regular,
                  subtitle1: theme.textTheme.subtitle1,
                  subtitle2: theme.textTheme.subtitle2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
