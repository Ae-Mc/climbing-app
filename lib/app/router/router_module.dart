import 'package:climbing_app/app/router/app_router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterModule {
  @singleton
  AppRouter appRouter() => AppRouter();
}
