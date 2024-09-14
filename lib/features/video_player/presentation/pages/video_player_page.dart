// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/features/video_player/presentation/widgets/custom_controls.dart';

import '../../../../injection_container.dart';
import '../cubit/video_player_cubit.dart';
import '../widgets/zoomer_widget.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({
    Key? key,
  }) : super(key: key);

  static createVideoPlayer({
    required BuildContext context,
    required int releaseId,
    required List<Episode> episodes,
    required int ordinal,
  }) {
    final linkedepisodes = LinkedList<EntryItem>();
    for (var episode in episodes) {
      linkedepisodes.add(EntryItem(releaseId: releaseId, episode: episode));
    }
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) {
          return BlocProvider(
              create: (context) {
                return VideoPlayerCubit(
                  getWatchedEpisodes: sl(),
                  saveWatchedEpisode: sl(),
                  episode: linkedepisodes.firstWhere(
                      (element) => element.episode.ordinal == ordinal),
                  linkedEpisodes: linkedepisodes,
                );
              },
              child: const VideoPlayerPage());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          await context.read<VideoPlayerCubit>().disposeController();
        },
        child: const Material(
          color: Colors.black,
          child: VideoPlayerWidget(),
        ));
  }
}

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({
    super.key,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: SystemUiOverlay.values);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
      if (state.status == VideoPlayerStatus.loaded) {
        return Stack(
          children: [
            Center(
              child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ZoomerWidget(
                      minScale: 1,
                      maxScale: 1.25,
                      child: VideoPlayer(state.videoPlayerController))),
            ),
            const CustomControls(),
          ],
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}

