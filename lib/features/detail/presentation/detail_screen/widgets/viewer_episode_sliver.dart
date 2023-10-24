import 'package:anime_app/constants/constants.dart';
import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/domain/entity/isar_data/watched_title.dart';
import 'package:anime_app/core/host.dart';
import 'package:anime_app/ui/screens/video_player_screen/video_player_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewerEpisodeSliver extends StatelessWidget {
  const ViewerEpisodeSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final title = context.read<AnimeTitle>();
    final watchedtitle = context.watch<WatchedTitle?>();
    final currentepisodeId = watchedtitle?.watchedEpisodes.last ?? 0;
    final currentEpisode = title.player?.list[currentepisodeId];
    final player = title.player;
    if (player == null) {
      return const SliverToBoxAdapter();
    }
    if (currentEpisode == null) {
      return const SliverToBoxAdapter();
    }
    final String preview =
        currentEpisode.preview ?? title.posters.original.url;

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: Stack(
          children: [
            Image(
              image: NetworkImage('${Host.host}$preview'),
              fit: BoxFit.cover,
              // height: 200,
              width: MediaQuery.sizeOf(context).width,
            ),
            Center(
              child: ElevatedButton(
                key: UniqueKey(),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_circle_filled_sharp),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('${currentEpisode.episode} ${Constants.episode}'),
                  ],
                ),
                onPressed: () {
                  VideoPlayerScreen.createVideoPlayer(
                      context, player.host, player.list, currentepisodeId);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
