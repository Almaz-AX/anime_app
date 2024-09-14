import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anime_app/core/host.dart';

import '../../../../assets.dart';
import '../../../../constants/constants.dart';
import '../../../../core/data/models/release.dart';
import '../../../../ui/components/continue_slider.dart';
import '../../../video_player/presentation/pages/video_player_page.dart';
import '../bloc/underseen_episodes_bloc/underseen_episodes_bloc.dart';
import 'underseen_loader_widget.dart';

class UnderseenEpisodes extends StatelessWidget {
  const UnderseenEpisodes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnderseenEpisodesBloc, UnderseenEpisodesState>(
      builder: (context, state) {
        switch (state.status) {
          case UnderseenEpisodesStatus.loading:
            return const UnerseenLoaderWiget();
          case UnderseenEpisodesStatus.failure:
            return Container();
          case UnderseenEpisodesStatus.success:
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
                      Release? underseenRelease;
                      for (Release release in state.underseenReleases) {
                        if (release.id ==
                            state.underseenEpisodes[index].releaseId) {
                          underseenRelease = release;
                          break;
                        }
                      }
                      final episodes = underseenRelease?.episodes;
                      if (episodes == null || underseenRelease == null) {
                        return Container();
                      }
                      final episode = episodes.firstWhere((episode) =>
                          episode.ordinal ==
                          state.underseenEpisodes[index].episodeNumber);
                      final continueTimestamp =
                          state.underseenEpisodes[index].continueTimestamp;
                      return EpisodeCard(
                        episode: episode,
                        underseenRelease: underseenRelease,
                        episodes: episodes,
                        continueTimestamp: continueTimestamp,
                        onTapCancel: () {
                          context.read<UnderseenEpisodesBloc>().add(
                              UnderSeenTitlesCompleteEvent(
                                  episode: state.underseenEpisodes[index]));
                        },
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }
}

class EpisodeCard extends StatelessWidget {
  const EpisodeCard(
      {super.key,
      required this.episode,
      required this.underseenRelease,
      required this.episodes,
      this.continueTimestamp = 0,
      this.onTapCancel});

  final Episode episode;
  final Release underseenRelease;
  final List<Episode> episodes;
  final int continueTimestamp;
  final VoidCallback? onTapCancel;

  @override
  Widget build(BuildContext context) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 160,
                        width: 260,
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Image.network(
                          '${Host.host}${episode.preview?.src ?? underseenRelease.poster.src}',
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                      onTap: () {
                        VideoPlayerPage.createVideoPlayer(
                            context: context,
                            releaseId: underseenRelease.id,
                            episodes: episodes,
                            ordinal: episode.ordinal);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      height: 25,
                      color: Colors.white70.withOpacity(0.5),
                      shape: const CircleBorder(),
                      minWidth: 0,
                      onPressed: onTapCancel,
                      child: ImageIcon(
                        const AssetImage(IconAseet.cancel),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  if (episode.duration != null)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ContinueSlider(width: 260 * continueTimestamp / episode.duration!),
                    )
                ],
              ),
            ),
          ),
          SizedBox(
            child: Text(
              underseenRelease.name.main,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Text(
            'Серия ${episode.ordinal}',
            maxLines: 1,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}

