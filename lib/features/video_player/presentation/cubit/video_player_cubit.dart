import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/injection_container.dart';
import '../../../../core/data/local/DAO/watched_episode_dao.dart';
import '../../../../core/data/local/entity/watched_episode.dart';
import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final WatchedEpisodesDAO animeDb = sl();

  VideoPlayerCubit(
      {required int titleId,
      required int currentEpisode,
      required String host,
      required List<Episode> episodes})
      : super(VideoPlayerState(
            titleId: titleId,
            currentEpisode: currentEpisode,
            host: host,
            episodes: episodes,
            videoPlayerController: VideoPlayerController.networkUrl(
                _getUrl(episode: episodes[currentEpisode], host: host)))) {
    _createChwieController();
  }

  static Uri _getUrl({required Episode episode, required String host}) {
    final hls = episode.hls;
    final videoUrl = hls.fhd ?? hls.hd ?? hls.sd;
    final url = Uri.parse('https://${host}$videoUrl');
    return url;
  }

  void nextEpisode() async {
    disposeControllers();
    animeDb.changeWatchedEpisode(WatchedEpisode(
        episodeNumber: state.currentEpisode,
        animeTitleId: state.titleId,
        continueTimestamp: 200));
    emit(state.copyWith(chewieController: null));
    final currentEpisode = state.currentEpisode + 1;
    final newVideoPlayerController = VideoPlayerController.networkUrl(
      _getUrl(episode: state.episodes[currentEpisode], host: state.host),
    );
    await newVideoPlayerController.initialize();
    final chewieController = state.chewieController
        ?.copyWith(videoPlayerController: newVideoPlayerController);
    emit(state.copyWith(
      currentEpisode: state.currentEpisode + 1,
      videoPlayerController: newVideoPlayerController,
      chewieController: chewieController,
    ));
  }

  void prevEpisode() {
    animeDb.deleteWatchedEpisode(WatchedEpisode(
      episodeNumber: state.currentEpisode,
      animeTitleId: state.titleId,
    ));
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

  Future<void> _createChwieController() async {
    await state.videoPlayerController.initialize();
    final chewieController = ChewieController(
      showControls: false,
      showControlsOnInitialize: false,
      // aspectRatio: 25/ 8,
      autoInitialize: true,
      videoPlayerController: state.videoPlayerController,
      useRootNavigator: true,
      autoPlay: true,
      placeholder: Container(
        color: Colors.black,
      ),
      materialProgressColors:
          ChewieProgressColors(playedColor: const Color(0xFF2EAEBE)),
      progressIndicatorDelay: const Duration(microseconds: 500),
    );
    emit(state.copyWith(chewieController: chewieController));
  }

  void disposeControllers() {
    state.videoPlayerController.dispose();
    state.chewieController?.dispose();
  }
}
