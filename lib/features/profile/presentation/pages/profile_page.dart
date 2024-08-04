import 'package:anime_app/constants/constants.dart';
import 'package:anime_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../widgets/exit_button.dart';
import '../widgets/user_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Row(
            children: [
              Text(Constants.profile),
              Expanded(
                  child: SizedBox(
                height: 5,
              )),
              ExitButton(),
            ],
          ),
          automaticallyImplyLeading: false),
      body: BlocProvider(
        create: (context) => sl<ProfileBloc>()..add(ProfileGetEvent()),
        child: ListView(
          children: const [UserWidget()],
        ),
      ),
    );
  }
}
