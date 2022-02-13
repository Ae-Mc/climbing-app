import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/guards/init_guard.dart';
import 'package:climbing_app/features/auth/presentation/pages/auth_page.dart';
import 'package:climbing_app/features/root/presentation/pages/root_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/routes_page.dart';
import 'package:climbing_app/features/splash/presentation/pages/splash_page.dart';
export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(
      guards: [InitGuard],
      page: RootPage,
      initial: true,
      children: [
        AutoRoute(guards: [InitGuard], page: AuthPage),
        AutoRoute(guards: [InitGuard], initial: true, page: RoutesPage),
      ],
    ),
    AutoRoute(page: SplashPage),
  ],
)
class $AppRouter {}
