import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class InfrastructureModule {
  @singleton
  Logger logger() => Logger(
        level: Level.debug,
        printer: PrettyPrinter(),
      );
}
