import 'package:flutter/material.dart';

class PreviosPauseNextWidget extends StatelessWidget {
  const PreviosPauseNextWidget(
      {super.key,
      this.onTapPrev,
      required this.isPlaying,
      this.onTapPause,
      this.onTapNext});
  final bool isPlaying;
  final VoidCallback? onTapPrev;
  final VoidCallback? onTapPause;
  final VoidCallback? onTapNext;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
        iconSize: 45,
        onPressed: onTapPrev,
        icon: const Icon(Icons.chevron_left_rounded),
      ),
      const SizedBox(
        width: 20,
      ),
      IconButton(
        iconSize: 45,
        onPressed: onTapPause,
        icon: isPlaying
            ? const Icon(Icons.pause_outlined)
            : const Icon(Icons.play_arrow_rounded),
        splashRadius: 20,
        splashColor: Colors.green,
        highlightColor: Colors.amberAccent,
      ),
      const SizedBox(
        width: 20,
      ),
      IconButton(
          iconSize: 45,
          onPressed: onTapNext,
          icon: const Icon(Icons.chevron_right_rounded),
          splashRadius: 50),
    ]);
  }
}
