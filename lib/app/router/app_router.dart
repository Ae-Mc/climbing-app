import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/app/router/app_router.gr.dart';
import 'package:climbing_app/app/router/guards/auth_guard.dart';
export 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AuthGuard authGuard;

  AppRouter({required this.authGuard});

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: AddAscentRoute.page, guards: [authGuard]),
        AutoRoute(page: AddCompetitionRoute.page, guards: [authGuard]),
        AutoRoute(
          page: AddRouteRootRoute.page,
          guards: [authGuard],
          children: [
            AutoRoute(page: AddRouteBasicsStepRoute.page, initial: true),
            AutoRoute(page: AddRouteCategoryStepRoute.page),
            AutoRoute(page: AddRouteImagesStepRoute.page),
          ],
        ),
        AutoRoute(page: ActivityFeedRoute.page),
        AutoRoute(page: ExpiringAscentsRoute.page, guards: [authGuard]),
        AutoRoute(page: MyCompetitionsRoute.page, guards: [authGuard]),
        AutoRoute(page: MyRoutesRoute.page, guards: [authGuard]),
        AutoRoute(page: ProfileRoute.page, guards: [authGuard]),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(
          path: '/password-reset/:token',
          page: ResetPasswordRoute.page,
        ),
        AutoRoute(
          initial: true,
          page: RootRoute.page,
          children: [
            AutoRoute(
              page: RatingRouterRoute.page,
              children: [
                AutoRoute(initial: true, page: RatingRoute.page),
                AutoRoute(page: UserRatingRoute.page),
              ],
            ),
            AutoRoute(
              page: RoutesRouterRoute.page,
              initial: true,
              children: [
                AutoRoute(initial: true, page: RoutesRoute.page),
              ],
            ),
          ],
        ),
        AutoRoute(page: RouteDetailsRoute.page),
        AutoRoute(page: UpdateRouteRoute.page),
        AutoRoute(page: RouteImagesRoute.page),
        AutoRoute(page: SignInRoute.page),
        AutoRoute(page: AccountDeletionRoute.page),
      ];
}
