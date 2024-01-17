import 'package:anime_app/core/host.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/assets.dart';
import '../../../../constants/constants.dart';
import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/data/models/anime_title.dart';

class UnderseenEpisodes extends StatelessWidget {
  const UnderseenEpisodes({super.key});

  @override
  Widget build(BuildContext context) {
    final underseenEpisodes = context.watch<List<WatchedEpisode>>();
    final underseenTitles = context.read<List<AnimeTitle>>();
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
            itemCount: underseenEpisodes.length,
            itemBuilder: (context, index) {
              AnimeTitle? underseenTitle;
              for (AnimeTitle title in underseenTitles) {
                if (title.id == underseenEpisodes[index].animeTitleId) {
                  underseenTitle = title;
                  break;
                }
              }
              final episode = underseenTitle
                  ?.player?.list[underseenEpisodes[index].episodeNumber];

              if (underseenTitle == null) {
                return Container();
              }
              if (episode == null) {
                return Container();
              }
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                onTap: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text('24 min',
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
                                    onPressed: () {},
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
                      'Серия ${(underseenEpisodes[index].episodeNumber + (underseenTitle.player?.episodes.first ?? 1)).toString()}',
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
  }
}
