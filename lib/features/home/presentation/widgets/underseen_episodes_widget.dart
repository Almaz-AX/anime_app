import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/assets.dart';
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
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 16),
          child: Text(
            'Continue watching',
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
              final episode = underseenTitles[index]
                  .player
                  ?.list[underseenEpisodes[index].episodeNumber];
              if (episode == null) {
                return Container();
              }
              return Container(
                height: 210,
                width: 260,
                padding: const EdgeInsets.only(right: 20),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: 260,
                          padding: const EdgeInsets.only(right: 20),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          underseenTitles[index].names.ru,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          underseenEpisodes[index].episodeNumber.toString(),
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: InkWell(
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Text('24 min',
                              style: Theme.of(context).textTheme.bodyMedium),
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
              );
            },
          ),
        ),
      ],
    );
  }
}
