import 'package:anime_app/ui/navigation/branches/search_page_branch.dart';
import 'package:anime_app/features/main/presentation/main_page.dart';
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
  debugLogDiagnostics: true,
  routes: [
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
