import 'package:anime_app/ui/navigation/branches/profile_screen_branch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../domain/repositories/auth_repository.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Для просмотра профиля необходимо авторизоваться',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          ElevatedButton(
            onPressed: () {
              sl<AuthRepository>().signIn();
              context.go(
                ProfileScreenPath.loader,
              );
            },
            child: const Text('Авторизация с помощью google'),
          ),
        ],
      ),
    );
  }
}
