// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../cubit/video_player_cubit.dart';

class CustomControls extends StatelessWidget {
  const CustomControls({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoPlayerCubit>();
    return GestureDetector(
      child: Stack(
        children: [
          Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                iconSize: 45,
                onPressed: () {
                  cubit.prevEpisode();
                },
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                iconSize: 45,
                onPressed: () {
                  cubit.pause();
                },
                icon: const Icon(Icons.play_arrow_rounded),
                splashRadius: 20,
                splashColor: Colors.green,
                highlightColor: Colors.amberAccent,
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                  iconSize: 45,
                  onPressed: () {
                    cubit.nextEpisode();
                  },
                  icon: const Icon(Icons.chevron_right_rounded),
                  splashRadius: 50),
            ]),
          ),
          IconButton(
              onPressed: () async {
                await Future.microtask(() => context.pop());
              },
              icon: const ImageIcon(AssetImage(IconAseet.cancel)),
              splashRadius: 20),
          const VideoSliderWidget()
        ],
      ),
    );
  }
}

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
  bool _mounted = false;
  @override
  void initState() {
    super.initState();
    videoPlayerController =
        context.read<VideoPlayerCubit>().state.videoPlayerController;
    videoPlayerController.addListener(currentPosotion);
    positionInSeconds = videoPlayerController.value.position.inSeconds;
    durationInSeconds = videoPlayerController.value.duration.inSeconds;
    _mounted = true;
  }

  void currentPosotion() {
    if (_mounted) {
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
    _mounted = false;
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
