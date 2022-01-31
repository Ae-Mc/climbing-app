import 'dart:async';

import 'package:climbing_app/app/app.dart';
import 'package:climbing_app/main.config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@InjectableInit(initializerName: r"$initGetIt")
void main() {
  // ignore: avoid-ignoring-return-values
  $initGetIt(GetIt.I);
  runZonedGuarded(() => runApp(const App()), (error, stacktrace) async {
    GetIt.I.get<Logger>().e('Critical error: ', error, stacktrace);
  });
}
