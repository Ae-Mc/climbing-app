import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class InfrastructureModule {
  @lazySingleton
  Logger logger() => Logger(
        level: Level.debug,
        printer: PrettyPrinter(),
      );

  @lazySingleton
  Dio dio() => Dio(BaseOptions(connectTimeout: 5000));

  @Injectable()
  FToast fToast(@factoryParam BuildContext context) => FToast().init(context);
}
