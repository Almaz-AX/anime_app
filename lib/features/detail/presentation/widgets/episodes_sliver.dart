// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/features/detail/presentation/blocs/detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/constants.dart';
import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/host.dart';
import '../../../video_player/presentation/pages/video_player_page.dart';

class EpisodesSliver extends StatelessWidget {
  const EpisodesSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final title = BlocProvider.of<DetailBloc>(context).state.title;
    final player = title?.player;
    if (player == null) {
      return const SliverToBoxAdapter();
    }
    final episodes = player.list;

    return SliverList.builder(
      itemBuilder: (context, index) {
        return EpisodeCard(
          index: index,
        );
      },
      itemCount: episodes.length,
    );
  }
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    required this.index,
  });
  final int index;

  WatchedEpisode? getEpisode(List<WatchedEpisode> watchedEpisodes) {
    for (WatchedEpisode watchedEpisode in watchedEpisodes) {
      if (watchedEpisode.episodeNumber == index) {
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

  String readTimeStamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    return '${date.day.toString()}.${date.month < 10 ? '0${date.month}' : date.month}.${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<DetailBloc>(context).state;
    final title = state.title;
    final player = title?.player;

    if (player == null || title == null) {
      return Container();
    }

    final episodes = player.list;
    final episode = episodes[index];
    final previewRelativeUrl = player.list.first.preview;
    String preview = '${Host.host}${title.posters.small.url}';
    if (previewRelativeUrl != null) {
      preview = '${Host.host}${episodes[index].preview}';
    }
    final watchedEpisodes =
        context.select((DetailBloc bloc) => state.watchedEpisodes);
    final watchedEpisode = getEpisode(watchedEpisodes);
    final icon =
        watchedEpisode != null ? Icons.check : Icons.play_arrow_rounded;

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
                            size: 85))
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 240),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${episode.episode} ${Constants.episode}',
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
                    Text(
                      '${Constants.added} ${readTimeStamp(episode.createdTimestamp)}',
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
                  player: player,
                  titleId: title.id,
                  currentEpisodeId: index,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
