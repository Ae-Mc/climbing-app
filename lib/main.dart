import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:traverse/generated/l10n.dart';
import 'package:traverse/screens/main_screen.dart';
import 'package:traverse/style.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:traverse/utils/database_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) {
        DatabaseHelper.instance.queryAll();
        return DatabaseHelper.instance;
      },
      child: MaterialApp(
        onGenerateTitle: (context) => S.current.ITMOClimbing,
        theme: Style.themeData,
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        supportedLocales: [
          Locale('ru'),
          Locale('en'),
        ],
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
