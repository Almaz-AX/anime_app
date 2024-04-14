// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
            videoPlayerController: _createVideoPlayerController(
                episode: player.list[currentEpisode], host: player.host))) {
    _initVideoPlayer();
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

  Future<void> _initVideoPlayer() async {
    final WatchedEpisode? watchedEpisode =
        await getWatchedEpisode(state.currentEpisode);

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

  static VideoPlayerController _createVideoPlayerController(
      {required Episode episode, required String host}) {
    final hls = episode.hls;
    final videoUrl = hls.fhd ?? hls.hd ?? hls.sd;
    final url = Uri.parse('https://$host$videoUrl');
    final controller = VideoPlayerController.networkUrl(url);
    return controller;
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
        episodeNumber: state.currentEpisode,
        animeTitleId: state.titleId,
        continueTimestamp: currentPositionInSeconds,
        watchCompleted: watchedCompleted)));
    state.videoPlayerController.dispose();
  }

  Future<void> _changeEpisode(int episodeNumber) async {
    emit(state.copyWith(status: VideoPlayerStatus.loading));
    await disposeController();
    final newVideoPlayerController = _createVideoPlayerController(
        episode: state.player.list[episodeNumber], host: state.player.host);
    emit(state.copyWith(
        currentEpisode: episodeNumber,
        videoPlayerController: newVideoPlayerController));
    await _initVideoPlayer();
  }
}
