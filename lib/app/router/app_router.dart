import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/features/routes/presentation/pages/route_details_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/route_images_page.dart';
import 'package:climbing_app/features/root/presentation/pages/root_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/routes_page.dart';
import 'package:climbing_app/features/user/presentation/pages/sign_in_page.dart';
import 'package:climbing_app/features/user/presentation/pages/profile_page.dart';
import 'package:climbing_app/features/user/presentation/pages/sign_up_page.dart';
export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(
      initial: true,
      page: RootPage,
      children: [
        AutoRoute(
          name: 'UserRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(initial: true, page: ProfilePage),
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
    AutoRoute(page: RouteImagesPage),
    AutoRoute(page: SignInPage),
    AutoRoute(page: SignUpPage),
  ],
)
class $AppRouter {}
