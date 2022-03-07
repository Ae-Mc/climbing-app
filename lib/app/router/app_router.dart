import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/guards/init_guard.dart';
import 'package:climbing_app/features/routes/presentation/pages/route_details_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/route_images_page.dart';
import 'package:climbing_app/features/user/presentation/pages/auth_page.dart';
import 'package:climbing_app/features/root/presentation/pages/root_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/routes_page.dart';
import 'package:climbing_app/features/splash/presentation/pages/splash_page.dart';
export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(
      guards: [InitGuard],
      initial: true,
      page: RootPage,
      children: [
        AutoRoute(
          name: 'AuthRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(initial: true, page: AuthPage),
          ],
        ),
        AutoRoute(
          name: 'RoutesRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(initial: true, page: RoutesPage),
            AutoRoute(page: RouteDetailsPage),
          ],
        ),
      ],
    ),
    AutoRoute(guards: [InitGuard], page: RouteImagesPage),
    AutoRoute(page: SplashPage),
  ],
)
class $AppRouter {}
