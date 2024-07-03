import 'package:anime_app/ui/navigation/branches/profile_screen_branch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/auth_bloc/auth_bloc.dart' as bloc;

class LoaderPage extends StatelessWidget {
  const LoaderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<bloc.AuthBloc, bloc.AuthState>(
        listener: ((context, state) {
          switch (state) {
            case bloc.AuthorizedState():
              context.go(ProfileScreenPath.profile);
              break;
            case bloc.NotAuthorizedState():
              context.go(ProfileScreenPath.login);
            case bloc.AuthUnknownState():
              return;
          }
        }),
        child: const Center(child: CircularProgressIndicator()));
  }
}
