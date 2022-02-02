import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';

class InitGuard implements AutoRouteGuard {
  final bool Function() isInited;

  InitGuard(this.isInited);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (!isInited()) {
      // ignore: avoid-ignoring-return-values
      router.push(SplashRoute(
        onLoad: () {
          resolver.next();
          // ignore: avoid-ignoring-return-values
          router.removeWhere((route) => route.name == SplashRoute.name);
        },
      ));
    } else {
      resolver.next();
    }
  }
}
