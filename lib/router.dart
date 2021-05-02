import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:itmo_climbing/pages/guides/guide_page.dart';
import 'package:itmo_climbing/pages/guides/guides_page.dart';
import 'package:itmo_climbing/pages/guides/track_page.dart';
import 'package:itmo_climbing/pages/guides/tracks_page.dart';
import 'package:itmo_climbing/pages/history/history_page.dart';
import 'package:itmo_climbing/pages/history/record/record_details_page.dart';
import 'package:itmo_climbing/pages/home/home_page.dart';
import 'package:itmo_climbing/pages/main_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      fullscreenDialog: true,
      initial: true,
      page: MainPage,
      path: '/',
      children: <AutoRoute>[
        AutoRoute(
          path: 'home',
          name: 'HomeRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: 'timer', page: HomePage),
            RedirectRoute(path: '', redirectTo: 'timer'),
            RedirectRoute(path: '*', redirectTo: 'timer'),
          ],
        ),
        AutoRoute(
          path: 'history',
          name: 'HistoryRouter',
          page: EmptyRouterPage,
          initial: true,
          children: [
            AutoRoute(path: '', page: HistoryPage),
            AutoRoute(path: 'details', page: RecordDetailsPage),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        AutoRoute(
          path: 'guide',
          name: 'GuideRouter',
          page: EmptyRouterPage,
          children: [
            AutoRoute(path: 'guides', page: GuidesPage),
            AutoRoute(path: 'guide', page: GuidePage),
            AutoRoute(path: 'tracks', page: TracksPage),
            AutoRoute(path: 'track', page: TrackPage),
            RedirectRoute(path: '', redirectTo: 'guides'),
            RedirectRoute(path: '*', redirectTo: ''),
          ],
        ),
        RedirectRoute(path: '', redirectTo: 'home'),
      ],
    ),
  ],
)
class $AppRouter {}
