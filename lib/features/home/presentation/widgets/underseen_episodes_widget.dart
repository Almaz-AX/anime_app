import 'package:anime_app/core/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/assets.dart';
import '../../../../constants/constants.dart';
import '../../../../core/data/models/anime_title.dart';
import '../../../video_player/presentation/pages/video_player_page.dart';
import '../bloc/underseen_episodes_bloc/underseen_episodes_bloc.dart';

class UnderseenEpisodes extends StatelessWidget {
  const UnderseenEpisodes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnderseenEpisodesBloc, UnderseenEpisodesState>(
      builder: (context, state) {
        if (state.status == UnderseenEpisodesStatus.success) {
          if (state.underseenEpisodes.isEmpty) {
            return Container();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  Constants.continueWatching,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(
                height: 232,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.underseenEpisodes.length,
                  itemBuilder: (context, index) {
                    AnimeTitle? underseenTitle;
                    for (AnimeTitle title in state.underseenTitles) {
                      if (title.id ==
                          state.underseenEpisodes[index].animeTitleId) {
                        underseenTitle = title;
                        break;
                      }
                    }
                    final player = underseenTitle?.player;
                    if (player == null || underseenTitle == null) {
                      return Container();
                    }
                    final episode = player
                        .list[state.underseenEpisodes[index].episodeNumber];
                    return Container(
                      padding: const EdgeInsets.only(right: 8),
                      width: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 160,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image(
                                        image: NetworkImage(
                                            '${Host.host}${episode.preview ?? underseenTitle.posters.small.url}'),
                                        width: 260,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ],
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      splashColor: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.5),
                                      onTap: () {
                                        VideoPlayerPage.createVideoPlayer(
                                            context: context,
                                            titleId: underseenTitle!.id,
                                            player: player,
                                            currentEpisodeId: state
                                                .underseenEpisodes[index]
                                                .episodeNumber);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(underseenTitle.type?.lenght ?? '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        const Expanded(
                                          child: SizedBox(
                                            height: 10,
                                          ),
                                        ),
                                        MaterialButton(
                                          height: 25,
                                          color:
                                              Colors.white70.withOpacity(0.5),
                                          shape: const CircleBorder(),
                                          minWidth: 0,
                                          onPressed: () {
                                            context
                                                .read<UnderseenEpisodesBloc>()
                                                .add(UnderSeenTitlesCompleteEvent(
                                                    episode:
                                                        state.underseenEpisodes[
                                                            index]));
                                          },
                                          child: ImageIcon(
                                            const AssetImage(IconAseet.cancel),
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Text(
                              underseenTitle.names.ru,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          Text(
                            'Серия ${(state.underseenEpisodes[index].episodeNumber + (underseenTitle.player?.episodes.first ?? 1)).toString()}',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
