import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/detail/presentation/pages/detail_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';

final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');

abstract class MainScreenPath {
  static const home = '/home';
  static const detail = '/home/details';
}

abstract class MainScreenBranch {
  static StatefulShellBranch create() {
    final branch = StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeKey,
      routes: [
        GoRoute(
          path: MainScreenPath.home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: MainScreenPath.detail,
          builder: (context, state) => DetailPage(id: state.extra as int),
        ),
      ],
    );
    return branch;
  }
}
