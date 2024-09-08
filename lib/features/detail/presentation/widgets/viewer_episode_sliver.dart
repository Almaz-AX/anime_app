import 'package:anime_app/constants/constants.dart';
import 'package:anime_app/core/data/models/release.dart';

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
    final release = state.release;
    final episodes = release?.episodes;
    final watchedEpisodes = state.watchedEpisodes;
    if (release == null) {
      return const SliverToBoxAdapter();
    }
    if (episodes == null || episodes.isEmpty) {
      return Container(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        height: 200,
        child: Image(
          image: NetworkImage('${Host.host}${release.poster.src}'),
          fit: BoxFit.cover,
        ),
      );
    }
    Episode currentEpisode = episodes.first;
    for (WatchedEpisode watchedEpisode in watchedEpisodes) {
      if (watchedEpisode.episodeNumber > currentEpisode.ordinal &&
          watchedEpisode.watchCompleted == false) {
        currentEpisode = episodes.firstWhere(
            (episode) => episode.ordinal == watchedEpisode.episodeNumber);
      }
    }
    final String preview = currentEpisode.preview?.src ?? release.poster.src;

    return SliverToBoxAdapter(
      child: Container(
        height: 200,
        color: Theme.of(context).primaryColor.withOpacity(0.1),
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
                    Text('${currentEpisode.ordinal} ${Constants.episode}'),
                  ],
                ),
                onPressed: () {
                  VideoPlayerPage.createVideoPlayer(
                    context: context,
                    episodes: episodes,
                    releaseId: release.id,
                    ordinal: currentEpisode.ordinal,
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
