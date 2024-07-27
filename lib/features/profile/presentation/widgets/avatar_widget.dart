import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  const AvatarWidget({
    super.key,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        radius: 80,
        backgroundColor: Colors.amber,
      ),
    );
  }
}