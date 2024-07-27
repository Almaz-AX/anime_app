import 'package:flutter/material.dart';

import 'upload_avatar.dart';

class UploadAvatarButton extends StatelessWidget {
  const UploadAvatarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 120, left: 120),
          child: IconButton(
              onPressed: () async {
                showBottomSheet(
                    context: context,
                    builder: (BuildContext context) => const UploadAvatar());
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 30,
              )),
        ));
  }
}