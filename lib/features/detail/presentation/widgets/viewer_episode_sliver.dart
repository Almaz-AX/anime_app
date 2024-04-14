import 'package:anime_app/constants/constants.dart';
import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/core/host.dart';
import 'package:anime_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:anime_app/features/video_player/presentation/pages/video_player_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

class ViewerEpisodeSliver extends StatelessWidget {
  const ViewerEpisodeSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<DetailBloc>(context).state;
    final title = state.title;
    final player = title?.player;
    final watchedEpisodes = state.watchedEpisodes;
    if (player == null || title == null) {
      return const SliverToBoxAdapter();
    }
    int currentEpisodeId = 0;
    for (WatchedEpisode watchedEpisode in watchedEpisodes) {
      if (watchedEpisode.episodeNumber > currentEpisodeId &&
          watchedEpisode.watchCompleted == false) {
        currentEpisodeId = watchedEpisode.episodeNumber;
      }
    }
    late final Episode currentEpisode = player.list[currentEpisodeId];
    final String preview = currentEpisode.preview ?? title.posters.original.url;

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
                  VideoPlayerPage.createVideoPlayer(
                    context: context,
                    player: player,
                    titleId: title.id,
                    currentEpisodeId: currentEpisodeId,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
