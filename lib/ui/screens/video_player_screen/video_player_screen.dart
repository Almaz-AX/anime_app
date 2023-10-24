// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/anime_title.dart';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:anime_app/ui/screens/video_player_screen/cubit/video_player_cubit.dart';
import 'package:anime_app/ui/screens/video_player_screen/custom_controls.dart';
import 'package:go_router/go_router.dart';


class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  static createVideoPlayer(BuildContext context, String host,
      List<Episode> episodes, int currentEpisodeId) {
    final title = context.read<AnimeTitle>();
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
              create: (context) {
                return VideoPlayerCubit(
                    titleId: title.id,
                    currentEpisode: currentEpisodeId,
                    host: host,
                    episodes: episodes);
              },
              child: const VideoPlayerScreen());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.pop();
        return Future.value(true);
      },
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: VideoPlayerWidget(),
      ),
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
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    cubit = context.read<VideoPlayerCubit>();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    cubit.disposeControllers();

    super.dispose();
  }

  Future<void> changeVisibilityControls() async {
    visibilityControls = !visibilityControls;
    // не совсем правильно работает
    if (visibilityControls == true) {
      Future.delayed(const Duration(seconds: 3), changeVisibilityControls);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
      final chewieController = state.chewieController;
      if (chewieController != null) {
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
