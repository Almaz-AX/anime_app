// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anime_app/features/video_player/presentation/widgets/custom_controls.dart';
import 'package:video_player/video_player.dart';

import '../../../../injection_container.dart';
import '../cubit/video_player_cubit.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({super.key});

  static createVideoPlayer({
    required BuildContext context,
    required int titleId,
    required Player player,
    required int currentEpisodeId,
  }) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
              create: (context) {
                return VideoPlayerCubit(
                  getWatchedEpisodes: sl(),
                  saveWatchedEpisode: sl(),
                  titleId: titleId,
                  currentEpisode: currentEpisodeId,
                  player: player,
                );
              },
              child: const VideoPlayerPage());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: VideoPlayerWidget(),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool visibilityControls = true;
  late final VideoPlayerCubit cubit;
  late final VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _mounted = true;
    changeVisibilityControls();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    cubit = context.read<VideoPlayerCubit>();
  }

  @override
  void dispose() {
    _mounted = false;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Future<void> changeVisibilityControls() async {
    visibilityControls = !visibilityControls;
    // не совсем правильно работает
    if (visibilityControls == true) {
      Future.delayed(const Duration(seconds: 3), changeVisibilityControls);
    }
    if (_mounted) setState(() {});
    ;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
      final chewieController = state.chewieController;
      if (state.status == VideoPlayerStatus.loaded &&
          chewieController != null) {
        return GestureDetector(
          onTap: () {
            changeVisibilityControls();
          },
          child: Stack(
            children: [
              Chewie(controller: chewieController),
              Visibility(
                  visible: visibilityControls, child: const CustomControls())
            ],
          ),
        );
      }
      return const Center(
          child: Align(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ));
    });
  }
}
