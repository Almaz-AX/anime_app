import 'package:anime_app/ui/navigation/branches/profile_screen_branch.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection_container.dart';
import '../../domain/repositories/auth_repository.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [UserWidget()],
      ),
    );
  }
}

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Stack(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.amber,
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 165),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.edit,
                      size: 30,
                    )),
              )),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    sl<AuthRepository>().signOut(); 
                    context.go(ProfileScreenPath.loader);
                  },
                  icon: const Icon(
                    Icons.exit_to_app_rounded,
                    size: 30,
                  )))
        ],
      ),
    );
  }
}
