import 'package:anime_app/ui/screens/favorites_screen/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _shellNavigatorFavoriteshKey = GlobalKey<NavigatorState>(debugLabel: 'favorites');
abstract class FavoritesScreenPath {
  static const favorites = '/favorites';
}

abstract class FavoritesScreenBranch {
  static StatefulShellBranch create() {
    final branch = StatefulShellBranch(
      navigatorKey: _shellNavigatorFavoriteshKey,
      routes: [
        GoRoute(
          path: FavoritesScreenPath.favorites,
          builder: (context, state) => const FavoritesScreen(),
        ),
      ],
    );
    return branch;
  }
}
