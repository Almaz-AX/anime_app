import 'dart:io';

import 'package:anime_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';

import '../../data/models/profile.dart';

class UploadAvatarButton extends StatelessWidget {
  const UploadAvatarButton({
    super.key, required this.profile,
  });
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 120, left: 120),
          child: IconButton(
              onPressed: () async {
                final selectedImage = await _pickImageFromGalery();
                if (!context.mounted || selectedImage == null) return;
                context.read<ProfileBloc>().add(ProfileChangeAvatarEvent(
                      selectedImage: selectedImage, profile: profile
                    ));
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 30,
              )),
        ));
  }

  Future<File?> _pickImageFromGalery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return returnedImage == null ? null : File(returnedImage.path);
  }
}
