import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:climbing_app/app/router/guards/auth_guard.dart';
import 'package:climbing_app/features/add_ascent/presentation/pages/add_ascent_page.dart';
import 'package:climbing_app/features/add_competition/presentation/pages/add_competition_page.dart';
import 'package:climbing_app/features/add_route/presentation/pages/add_route_root_page.dart';
import 'package:climbing_app/features/add_route/presentation/pages/add_route_basics_step_page.dart';
import 'package:climbing_app/features/add_route/presentation/pages/add_route_category_step_page.dart';
import 'package:climbing_app/features/add_route/presentation/pages/add_route_images_step_page.dart';
import 'package:climbing_app/features/rating/presentation/pages/rating_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/route_details_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/route_images_page.dart';
import 'package:climbing_app/features/root/presentation/pages/root_page.dart';
import 'package:climbing_app/features/routes/presentation/pages/routes_page.dart';
import 'package:climbing_app/features/user/presentation/pages/expiring_ascents_page.dart';
import 'package:climbing_app/features/user/presentation/pages/my_routes_page.dart';
import 'package:climbing_app/features/user/presentation/pages/sign_in_page.dart';
import 'package:climbing_app/features/user/presentation/pages/profile_page.dart';
import 'package:climbing_app/features/user/presentation/pages/register_page.dart';
export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(page: AddAscentPage, guards: [AuthGuard]),
    AutoRoute(page: AddCompetitionPage, guards: [AuthGuard]),
    AutoRoute(
      page: AddRouteRootPage,
      guards: [AuthGuard],
      children: [
        AutoRoute(page: AddRouteBasicsStepPage, initial: true),
        AutoRoute(page: AddRouteCategoryStepPage),
        AutoRoute(page: AddRouteImagesStepPage),
      ],
    ),
    AutoRoute(page: ExpiringAscentsPage, guards: [AuthGuard]),
    AutoRoute(page: MyRoutesPage, guards: [AuthGuard]),
    AutoRoute(page: ProfilePage, guards: [AuthGuard]),
    AutoRoute(page: RegisterPage),
    AutoRoute(
      initial: true,
      page: RootPage,
      children: [
        AutoRoute(
          name: 'RatingRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(initial: true, page: RatingPage),
          ],
        ),
        AutoRoute(
          name: 'RoutesRouter',
          page: EmptyRouterPage,
          initial: true,
          children: [
            AutoRoute(initial: true, page: RoutesPage),
          ],
        ),
      ],
    ),
    AutoRoute(page: RouteDetailsPage),
    AutoRoute(page: RouteImagesPage),
    AutoRoute(page: SignInPage),
  ],
)
class $AppRouter {}
