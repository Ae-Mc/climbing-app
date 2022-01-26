import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:itmo_climbing/generated/l10n.dart';
import 'package:itmo_climbing/router.gr.dart';
import 'package:itmo_climbing/theme/style.dart';
import 'package:itmo_climbing/utils/database_helper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        DatabaseHelper.instance.queryAll();
        return DatabaseHelper.instance;
      },
      child: MaterialApp.router(
        onGenerateTitle: (context) => S.current.ITMOClimbing,
        theme: Style().themeData,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [
          Locale('ru'),
          Locale('en'),
        ],
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
