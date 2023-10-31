import 'package:anime_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

abstract class ProfileScreenPath {
  static const profile = '/profile';
}

abstract class ProfileScreenBranch {
  static StatefulShellBranch create() {
    final branch = StatefulShellBranch(
      navigatorKey: _shellNavigatorProfileKey,
      routes: [
        GoRoute(
          path: ProfileScreenPath.profile,
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    );
    return branch;
  }
}
