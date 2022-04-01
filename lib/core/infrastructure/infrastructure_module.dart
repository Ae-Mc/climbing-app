import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class InfrastructureModule {
  @lazySingleton
  Logger logger() => Logger(level: Level.debug, printer: PrettyPrinter());

  @lazySingleton
  Dio dio() => Dio(BaseOptions(connectTimeout: 5000));

  @preResolve
  Future<SharedPreferences> sharedPreferences() async =>
      await SharedPreferences.getInstance();

  @Injectable()
  FToast fToast(@factoryParam BuildContext context) => FToast().init(context);

  @lazySingleton
  DateFormat dateFormat() => DateFormat('y-MM-d');
}
