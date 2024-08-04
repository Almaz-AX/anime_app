import 'package:anime_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:anime_app/features/profile/presentation/widgets/change_user_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../blocs/change_user_name_bloc/change_user_name_bloc.dart';
import 'avatar_widget.dart';
import 'upload_avatar_button.dart';

class UserWidget extends StatelessWidget {
  const UserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          switch (state) {
            case ProfileInitial():
              return const Center(child: CircularProgressIndicator());
            case ProfileUser():
              return Column(
                children: [
                  Stack(
                    children: [
                      AvatarWidget(avatarUrl: state.user.avatarUrl),
                      UploadAvatarButton(
                        profile: state.user,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      final String? rez = await showModalBottomSheet(
                          context: context,
                          builder: (context) => BlocProvider(
                                create: (context) => sl<ChangeUserNameBloc>(),
                                child: ChangeUserName(
                                  userName: state.user.userName,
                                ),
                              ));
                      if (context.mounted && rez != null) {
                        context.read<ProfileBloc>().add(ProfileGetEvent());
                      }
                    },
                    child: Text(state.user.userName,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
