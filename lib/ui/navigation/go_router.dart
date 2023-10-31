import 'package:anime_app/ui/navigation/branches/search_page_branch.dart';
import 'package:anime_app/features/home/presentation/pages/main_page.dart';
import 'package:go_router/go_router.dart';

import 'branches/main_screen_branch.dart';
import 'branches/favorites_screen_branch.dart';
import 'branches/profile_screen_branch.dart';

class MainNavigationRouteNames {
  static const home = 'home';
  static const videoPlayer = 'videoPlayer';
}

final goRouter = GoRouter(
  initialLocation: '/home',
  // * Passing a navigatorKey causes an issue on hot reload:
  // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
  // * However it's still necessary otherwise the navigator pops back to
  // * root on hot reload

  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },
      branches: [
        MainScreenBranch.create(),
        SearchScreenBranch.create(),
        FavoritesScreenBranch.create(),
        ProfileScreenBranch.create(),
      ],
    ),
  ],
);
