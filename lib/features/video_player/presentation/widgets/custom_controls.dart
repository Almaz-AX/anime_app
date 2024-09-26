// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/features/video_player/presentation/widgets/video_slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../../assets.dart';
import '../cubit/video_player_cubit.dart';
import 'previous_next_pause_widget.dart';
import 'skip_or_continue_opening_widget.dart';

class CustomControls extends StatefulWidget {
  const CustomControls({
    super.key,
  });

  @override
  State<CustomControls> createState() => _CustomControlsState();
}

class _CustomControlsState extends State<CustomControls> {
  late final VideoPlayerController videoPlayerController;
  late final Ing? opening;
  bool visibleControls = true;
  bool isBuffering = true;
  bool showSkipOpeningButtons = false;
  Timer? skipOpeningTimer;

  Timer? timer;
  @override
  void initState() {
    super.initState();
    final state = context.read<VideoPlayerCubit>().state;
    videoPlayerController = state.videoPlayerController;
    opening = state.episode.episode.opening;
    videoPlayerController.addListener(_listenBuffering);
    videoPlayerController.addListener(_skipOpening);
  }

  void _skipOpening() {
    if (opening?.start == null || opening?.stop == null) {
      videoPlayerController.removeListener(_skipOpening);
      return;
    }
    int position = videoPlayerController.value.position.inSeconds;
    if (position > opening!.start! && position < opening!.stop! - 2) {
      changeVisibilityControls();
      showSkipOpeningButtons = true;
      skipOpeningTimer = Timer(const Duration(seconds: 3), () {
        showSkipOpeningButtons = false;
        videoPlayerController.removeListener(_skipOpening);
        videoPlayerController.seekTo(Duration(seconds: opening!.stop!));
      });
    }
  }

  void changeVisibilityControls() {
    visibleControls = true;
    timer?.cancel();
    timer = Timer(const Duration(seconds: 3), () {
      visibleControls = false;
    });
    setState(() {});
  }

  void _listenBuffering() {
    isBuffering = videoPlayerController.value.isBuffering;
    if (isBuffering) {
      changeVisibilityControls();
    }
    setState(() {});
  }

  @override
  void dispose() {
    videoPlayerController.removeListener(_skipOpening);
    videoPlayerController.removeListener(_listenBuffering);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<VideoPlayerCubit>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPressDown: (details) => timer?.cancel(),
      onTap: changeVisibilityControls,
      child: Visibility(
        replacement: Center(child: Container()),
        visible: visibleControls,
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Stack(
            children: [
              Center(
                child: isBuffering
                    ? const CircularProgressIndicator()
                    : PreviosPauseNextWidget(
                        isPlaying: videoPlayerController.value.isPlaying,
                        onTapPrev: cubit.state.episode.previous != null
                            ? () => cubit.changeEpisode(
                                cubit.state.episode.previous!.episode)
                            : null,
                        onTapPause: () => videoPlayerController.value.isPlaying
                            ? videoPlayerController.pause()
                            : videoPlayerController.play(),
                        onTapNext: cubit.state.episode.next != null
                            ? () => cubit.changeEpisode(
                                cubit.state.episode.next!.episode)
                            : null),
              ),
              IconButton(
                  onPressed: () async {
                    await Future.microtask(() => context.pop());
                  },
                  icon: const ImageIcon(AssetImage(IconAseet.cancel)),
                  splashRadius: 20),
              const VideoSliderWidget(),
              if (showSkipOpeningButtons)
                SkipOrContinueOpening(
                  onTapContinue: () {
                    skipOpeningTimer?.cancel();
                    videoPlayerController.removeListener(_skipOpening);
                    setState(() => showSkipOpeningButtons = false);
                  },
                  onTapSkip: () {
                    videoPlayerController.removeListener(_skipOpening);
                    videoPlayerController
                        .seekTo(Duration(seconds: opening!.stop!));
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
