import 'package:flutter/material.dart';

class UploadAvatar extends StatefulWidget {
  const UploadAvatar({super.key});

  @override
  State<UploadAvatar> createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
    );
    // final image = ImagePicker();
    // final ximage =
    //     await image.pickImage(source: ImageSource.gallery);
    // Image.file(File(ximage!.path));
  }
}
