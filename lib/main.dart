import 'dart:async';

import 'package:climbing_app/app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

void main() {
  runZonedGuarded(() => runApp(const App()), (error, stacktrace) async {
    GetIt.I
        .get<Logger>()
        .e('Critical error: ', error: error, stackTrace: stacktrace);
  });
}
