import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_page.dart';

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
            onPressed: () async {
              await sl<AuthRepository>().signIn();
            },
            child: const Text('Авторизация с помощью google'),
          ),
        ],
      ),
    );
  }
}
