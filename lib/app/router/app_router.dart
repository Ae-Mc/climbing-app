import 'package:auto_route/auto_route.dart';
import 'package:climbing_app/features/splash/presentation/pages/splash_page.dart';
export 'app_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: [
    AutoRoute(
      page: SplashPage,
      initial: true,
    ),
  ],
)
class $AppRouter {}
