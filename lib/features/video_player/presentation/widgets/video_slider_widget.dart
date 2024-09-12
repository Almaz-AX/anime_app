import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../cubit/video_player_cubit.dart';

class VideoSliderWidget extends StatefulWidget {
  const VideoSliderWidget({
    super.key,
  });

  @override
  State<VideoSliderWidget> createState() => _VideoSliderWidgetState();
}

class _VideoSliderWidgetState extends State<VideoSliderWidget> {
  late final VideoPlayerController videoPlayerController;
  late int positionInSeconds;
  late final int durationInSeconds;
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        context.read<VideoPlayerCubit>().state.videoPlayerController;
    videoPlayerController.addListener(currentPosotion);
    positionInSeconds = videoPlayerController.value.position.inSeconds;
    durationInSeconds = videoPlayerController.value.duration.inSeconds;
  }

  void currentPosotion() {
    if (mounted) {
      setState(() {
        positionInSeconds = videoPlayerController.value.position.inSeconds;
      });
    }
  }

  String _timeFormat(int value) {
    if (value < 10) {
      return '0$value';
    }
    return value.toString();
  }

  String showTime(int value) {
    final seconds = value % 60;
    final minutes = value ~/ 60;
    if (minutes > 59) {
      return '${_timeFormat(minutes % 60)} :${_timeFormat(minutes ~/ 60)}: ${_timeFormat(seconds)}';
    }
    return '${_timeFormat(minutes)} : ${_timeFormat(seconds)}';
  }

  @override
  void dispose() {
    videoPlayerController.removeListener(currentPosotion);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Expanded(child: SizedBox()),
      Row(children: [
        Expanded(
          child: Slider(
            thumbColor: Theme.of(context).primaryColor,
            activeColor: Theme.of(context).primaryColor,
            value: positionInSeconds.toDouble(),
            max: durationInSeconds.toDouble(),
            onChanged: (value) {
              videoPlayerController.seekTo(Duration(seconds: value.toInt()));
            },
          ),
        ),
        Text('${showTime(positionInSeconds)} / ${showTime(durationInSeconds)}'),
        const SizedBox(
          width: 5,
        )
      ]),
    ]);
  }
}
