import 'package:anime_app/ui/components/continue_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/constants.dart';
import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/data/models/release.dart';
import '../../../../core/host.dart';
import '../../../video_player/presentation/pages/video_player_page.dart';
import '../blocs/detail_bloc.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    required this.index,
  });
  final int index;

  WatchedEpisode? getEpisode(
      List<WatchedEpisode> watchedEpisodes, Episode episode) {
    for (WatchedEpisode watchedEpisode in watchedEpisodes) {
      if (watchedEpisode.episodeNumber == episode.ordinal) {
        return watchedEpisode;
      }
    }
    return null;
  }

  bool getWatchedEpisodeStatus(WatchedEpisode? watchedEpisode) {
    if (watchedEpisode == null) {
      return false;
    }
    return watchedEpisode.watchCompleted;
  }

  String formatTime(DateTime date) {
    return '${date.day.toString()}.${date.month < 10 ? '0${date.month}' : date.month}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<DetailBloc>(context).state;
    final release = BlocProvider.of<DetailBloc>(context).state.release;
    final episodes = release?.episodes;

    if (release == null || episodes == null) {
      return const SliverToBoxAdapter();
    }

    final episode = episodes[index];
    final previewRelativeUrl = episode.preview?.src;

    String preview = '${Host.host}${release.poster.src}';
    if (previewRelativeUrl != null) {
      preview = '${Host.host}$previewRelativeUrl';
    }
    final watchedEpisodes =
        context.select((DetailBloc bloc) => state.watchedEpisodes);
    final watchedEpisode = getEpisode(watchedEpisodes, episode);
    final icon = watchedEpisode != null && watchedEpisode.watchCompleted
        ? Icons.check
        : Icons.play_arrow_rounded;

    return Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      height: 130,
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 200,
                child: Stack(
                  children: [
                    Image(
                      image: NetworkImage(preview),
                      fit: BoxFit.fitWidth,
                      width: 200,
                    ),
                    Center(
                        child: Icon(icon,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.8),
                            size: 85)),
                    if (watchedEpisode != null &&
                        episode.duration != null &&
                        watchedEpisode.continueTimestamp != 0)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ContinueSlider(
                          width:200 * watchedEpisode.continueTimestamp/episode.duration!,
                        ),
                      )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${episode.ordinal} ${Constants.episode}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (episode.name != null)
                      Text(episode.name!,
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(
                      height: 5,
                    ),
                    if (episode.updatedAt != null)
                      Text(
                        '${Constants.added} ${formatTime(episode.updatedAt!)}',
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontSize: 13),
                      ),
                  ],
                ),
              )
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                VideoPlayerPage.createVideoPlayer(
                  context: context,
                  episodes: episodes,
                  releaseId: release.id,
                  ordinal: episodes[index].ordinal,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
