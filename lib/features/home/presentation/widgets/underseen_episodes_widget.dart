import 'package:anime_app/core/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/assets.dart';
import '../../../../constants/constants.dart';
import '../../../../core/data/models/anime_title.dart';
import '../../../video_player/presentation/pages/video_player_page.dart';
import '../bloc/home_bloc.dart';

class UnderseenEpisodes extends StatelessWidget {
  const UnderseenEpisodes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const CircularProgressIndicator();
        }
        if (state.status == HomeStatus.success) {
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
                    return SizedBox(
                      width: 260,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 160,
                            width: 260,
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        '${Host.host}${episode.preview ?? underseenTitle.posters.small.url}',
                                        fit: BoxFit.cover,
                                        cacheHeight: 165,
                                        cacheWidth: 260,
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
                                    padding: const EdgeInsets.only(left: 10),
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
                                          shape: const CircleBorder(),
                                          minWidth: 0,
                                          onPressed: () {
                                            context.read<HomeBloc>().add(
                                                HomeCompleteWatchingEvent(
                                                    episode:
                                                        state.underseenEpisodes[
                                                            index]));
                                          },
                                          child: const ImageIcon(
                                            AssetImage(IconAseet.cancel),
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
