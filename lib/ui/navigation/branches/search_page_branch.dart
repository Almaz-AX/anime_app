import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../../features/detail/presentation/pages/detail_page.dart';
import '../../../features/search/presentation/pages/search_page.dart';

final _shellNavigatorSearchKey =
    GlobalKey<NavigatorState>(debugLabel: 'search');

abstract class SearchScreenPath {
  static const search = '/search';
  static const detail = '/search/details';
  static const videoPlayer = '/search/videoPlayer';
}

abstract class SearchScreenBranch {
  static StatefulShellBranch create() {
    final branch = StatefulShellBranch(
      navigatorKey: _shellNavigatorSearchKey,
      routes: [
        GoRoute(
          path: SearchScreenPath.search,
          builder: (context, state) => const SearchPage(),
        ),
        GoRoute(
          path: SearchScreenPath.detail,
          builder: (context, state) => DetailPage(id:state.extra as int),
        ),
      ],
    );
    return branch;
  }
}
