import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/data/models/anime_title.dart';
import '../../domain/usecases/save_watched_episode.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../domain/usecases/get_watched_episodes.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final SaveWatchedEpisode saveWatchedEpisode;
  final GetWatchedEpisodes getWatchedEpisodes;

  VideoPlayerCubit({
    required this.saveWatchedEpisode,
    required this.getWatchedEpisodes,
    required int titleId,
    required int currentEpisode,
    required Player player,
  }) : super(VideoPlayerState(
            status: VideoPlayerStatus.loading,
            titleId: titleId,
            currentEpisode: currentEpisode,
            player: player,
            videoPlayerController: VideoPlayerController.networkUrl(_getUrl(
                episode: player.list[currentEpisode], host: player.host)))) {
    getWatchedEpisode(currentEpisode).then((episode) => _createChwieController(
            state.videoPlayerController, episode?.continueTimestamp)
        .then((value) => emit(state.copyWith(
            status: VideoPlayerStatus.loaded, chewieController: value))));
  }

  Future<WatchedEpisode?> getWatchedEpisode(int episodeNumber) async {
    final episodesOrFailure = await getWatchedEpisodes(Params(state.titleId));
    WatchedEpisode? watchedEpisode;
    episodesOrFailure.fold((l) => null, (watchedEpisodes) {
      for (WatchedEpisode episode in watchedEpisodes) {
        if (episode.episodeNumber == episodeNumber) {
          watchedEpisode = episode;
        }
      }
    });
    return watchedEpisode;
  }

  static Uri _getUrl({required Episode episode, required String host}) {
    final hls = episode.hls;
    final videoUrl = hls.fhd ?? hls.hd ?? hls.sd;
    final url = Uri.parse('https://$host$videoUrl');
    return url;
  }

  Future<void> nextEpisode() async {
    final nextEpisodeNumber = state.currentEpisode + 1;
    if (nextEpisodeNumber < state.player.list.length) {
      await _changeEpisode(nextEpisodeNumber);
    }
  }

  Future<void> prevEpisode() async {
    final prevEpisodeNumber = state.currentEpisode - 1;
    if (prevEpisodeNumber < 0) {
      await _changeEpisode(0);
      return;
    }
    await _changeEpisode(prevEpisodeNumber);
  }

  void pause() {
    final chewieController = state.chewieController;
    if (chewieController == null) {
      return;
    }
    if (chewieController.isPlaying) {
      chewieController.pause();
      return;
    }
    chewieController.play();
  }

  Future<void> disposeControllers() async {
    state.chewieController?.isPlaying ?? state.chewieController?.pause();
    bool watchedCompleted = false;
    final currentPositionInSeconds =
        state.videoPlayerController.value.position.inSeconds;
    final durationInSeconds =
        state.videoPlayerController.value.duration.inSeconds;
    if (currentPositionInSeconds / durationInSeconds > 0.9) {
      watchedCompleted = true;
    }
    await saveWatchedEpisode(EpisodeParams(WatchedEpisode(
        updatedTime: DateTime.timestamp().millisecondsSinceEpoch,
        episodeNumber: state.currentEpisode,
        animeTitleId: state.titleId,
        continueTimestamp: currentPositionInSeconds,
        watchCompleted: watchedCompleted)));
    state.videoPlayerController.dispose();
    state.chewieController?.dispose();
  }

  Future<ChewieController> _createChwieController(
      VideoPlayerController videoPlayerController,
      int? continueTimestamp) async {
    await videoPlayerController.initialize();
    final chewieController = ChewieController(
      startAt: Duration(seconds: continueTimestamp ?? 0),
      showControls: false,
      showControlsOnInitialize: false,
      // aspectRatio: 25/ 8,
      autoInitialize: true,
      videoPlayerController: videoPlayerController,
      useRootNavigator: true,
      autoPlay: true,
      placeholder: Container(
        color: Colors.black,
      ),
      materialProgressColors:
          ChewieProgressColors(playedColor: const Color(0xFF2EAEBE)),
      progressIndicatorDelay: const Duration(microseconds: 500),
    );
    return chewieController;
  }

  Future<void> _changeEpisode(int episodeNumber) async {
    emit(state.copyWith(status: VideoPlayerStatus.loading));
    disposeControllers();

    final newVideoPlayerController = VideoPlayerController.networkUrl(
      _getUrl(
          episode: state.player.list[episodeNumber], host: state.player.host),
    );
    final watchedEpisode = await getWatchedEpisode(episodeNumber);
    final chewieController = await _createChwieController(
        newVideoPlayerController, watchedEpisode?.continueTimestamp);

    emit(state.copyWith(
      status: VideoPlayerStatus.loaded,
      currentEpisode: episodeNumber,
      videoPlayerController: newVideoPlayerController,
      chewieController: chewieController,
    ));
  }
}
