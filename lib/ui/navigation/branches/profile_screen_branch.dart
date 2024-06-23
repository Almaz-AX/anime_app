import 'package:anime_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:anime_app/features/profile/presentation/pages/auth_page.dart';
import 'package:anime_app/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/profile/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../../../injection_container.dart';

final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

abstract class ProfileScreenPath {
  static const profile = '/profile';
  static const login = '/login';
}

abstract class ProfileScreenBranch {
  static StatefulShellBranch create() {
    final branch = StatefulShellBranch(
      navigatorKey: _shellNavigatorProfileKey,
      routes: [
        GoRoute(
          path: ProfileScreenPath.login,
          builder: (context, state) => BlocProvider(
            create: (context) => sl<AuthBloc>()..add(const AuthStatusEvent()),
            child: const AuthPage(),
          ),
        ),
        GoRoute(
          path: ProfileScreenPath.profile,
          builder: (context, state) => BlocProvider(
            create: (context) => sl<ProfileBloc>(),
            child: const ProfilePage(),
          ),
        ),
      ],
    );
    return branch;
  }
}
