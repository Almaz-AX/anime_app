import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../../../ui/navigation/branches/profile_screen_branch.dart';
import '../../domain/repositories/auth_repository.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: IconButton(
            onPressed: () {
              sl<AuthRepository>().signOut();
              context.go(ProfileScreenPath.loader);
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
              size: 30,
            )));
  }
}