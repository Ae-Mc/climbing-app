import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final bool Function() isAuthenticated;

  AuthGuard(this.isAuthenticated);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // ignore: dead_code
    if (isAuthenticated()) {
      resolver.next();
    } else {
      // ignore: avoid-ignoring-return-values
      router.push(SignInRoute(onSuccessLogin: () => resolver.next()));
    }
  }
}
