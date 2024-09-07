// ignore: depend_on_referenced_packages
import 'dart:collection';

import 'package:anime_app/core/data/models/release.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

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
    required EntryItem episode,
    required LinkedList<EntryItem> linkedEpisodes,
  }) : super(VideoPlayerState(
            status: VideoPlayerStatus.loading,
            episode: episode,
            linkedEpisodes: linkedEpisodes,
            videoPlayerController:
                _createVideoPlayerController(episode: episode.episode))) {
    _initVideoPlayer();
  }

  Future<WatchedEpisode?> getWatchedEpisode(int episodeNumber) async {
    final episodesOrFailure =
        await getWatchedEpisodes(Params(state.episode.releaseId));
    WatchedEpisode? watchedEpisode;
    episodesOrFailure.fold((l) => null, (watchedEpisodes) {
      watchedEpisode = watchedEpisodes
          .where((element) => element.episodeNumber == episodeNumber)
          .firstOrNull;
    });
    return watchedEpisode;
  }

  Future<void> _initVideoPlayer() async {
    final WatchedEpisode? watchedEpisode =
        await getWatchedEpisode(state.episode.episode.ordinal);

    await state.videoPlayerController.initialize();
    await state.videoPlayerController.play();
    if (watchedEpisode != null) {
      state.videoPlayerController
          .seekTo(Duration(seconds: watchedEpisode.continueTimestamp));
    }
    emit(
      state.copyWith(status: VideoPlayerStatus.loaded),
    );
  }

  static VideoPlayerController _createVideoPlayerController({
    required Episode episode,
  }) {
    final String videoUrl = episode.hls1080 ?? episode.hls720 ?? episode.hls480;
    final url = Uri.parse(videoUrl);
    final controller = VideoPlayerController.networkUrl(url);
    return controller;
  }

  Future<void> nextEpisode() async {
    final episode = state.episode.next?.episode;
    if (episode == null) {
      return;
    }
    await _changeEpisode(episode);
  }

  Future<void> prevEpisode() async {
    final episode = state.episode.previous?.episode;
    if (episode == null) {
      return;
    }
    await _changeEpisode(episode);
  }

  void pause() {
    final controller = state.videoPlayerController;
    if (controller.value.isPlaying) {
      controller.pause();
      return;
    }
    controller.play();
  }

  Future<void> disposeController() async {
    state.videoPlayerController.pause();
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
        episodeNumber: state.episode.episode.ordinal,
        releaseId: state.episode.releaseId,
        continueTimestamp: currentPositionInSeconds,
        watchCompleted: watchedCompleted)));
    state.videoPlayerController.dispose();
  }

  Future<void> _changeEpisode(Episode episode) async {
    emit(state.copyWith(
      status: VideoPlayerStatus.loading,
    ));
    await disposeController();
    final newVideoPlayerController =
        _createVideoPlayerController(episode: episode);
    emit(state.copyWith(
        episode: state.episode.next,
        videoPlayerController: newVideoPlayerController));
    await _initVideoPlayer();
  }
}
