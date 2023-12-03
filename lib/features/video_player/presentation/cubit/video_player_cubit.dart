import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/video_player/domain/usecases/save_watched_episode.dart';
import '../../../../core/data/local/entity/watched_episode.dart';
import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerChengedEpisodeState> {
  final SaveWatchedEpisode saveWatchedEpisode;

  VideoPlayerCubit(
      {required this.saveWatchedEpisode,
      required int titleId,
      required int currentEpisode,
      required String host,
      required List<Episode> episodes,
      int continuetimestamp = 0})
      : super(VideoPlayerChengedEpisodeState(
            titleId: titleId,
            currentEpisode: currentEpisode,
            host: host,
            episodes: episodes,
            videoPlayerController: VideoPlayerController.networkUrl(
                _getUrl(episode: episodes[currentEpisode], host: host)))) {
    _createChwieController(continueTimestamp: continuetimestamp);
  }

  void createVideoPlayer(
      {required int titleId,
      required int currentEpisode,
      required String host,
      required List<Episode> episodes,
      continuetimestamp = 0}) {
    _createChwieController(continueTimestamp: continuetimestamp);
    emit(VideoPlayerChengedEpisodeState(
        titleId: titleId,
        currentEpisode: currentEpisode,
        host: host,
        episodes: episodes,
        videoPlayerController: VideoPlayerController.networkUrl(
            _getUrl(episode: episodes[currentEpisode], host: host))));
  }

  static Uri _getUrl({required Episode episode, required String host}) {
    final hls = episode.hls;
    final videoUrl = hls.fhd ?? hls.hd ?? hls.sd;
    final url = Uri.parse('https://$host$videoUrl');
    return url;
  }

  Future<void> nextEpisode() async {
    final nextEpisodeNumber = state.currentEpisode + 1;
    if (nextEpisodeNumber < state.episodes.length) {
      await _changeEpisode(nextEpisodeNumber);
    }
  }

  Future<void> prevEpisode() async {
    final prevEpisodeNumber = state.currentEpisode - 1;
    if (prevEpisodeNumber >= 0) {
      await _changeEpisode(prevEpisodeNumber);
    }
  }

  Future<int?> pause() async {
    final chewieController = state.chewieController;
    if (chewieController == null) {
      return Future(() => null);
    }
    if (chewieController.isPlaying) {
      chewieController.pause();
      return Future.value(
          (await chewieController.videoPlayerController.position)?.inSeconds);
    }

    chewieController.play();
    return Future.value(
        (await chewieController.videoPlayerController.position)?.inSeconds);
  }

  Future<void> disposeControllers() async {
    saveWatchedEpisode(Params(WatchedEpisode(
        episodeNumber: state.currentEpisode,
        animeTitleId: state.titleId,
        continueTimestamp: (await pause()) ?? 0)));
    state.videoPlayerController.dispose();
    state.chewieController?.dispose();
  }

  Future<void> _createChwieController({int continueTimestamp = 0}) async {
    await state.videoPlayerController.initialize();
    final chewieController = ChewieController(
      startAt: Duration(seconds: continueTimestamp),
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

  Future<void> _changeEpisode(int episodeNumber) async {
    disposeControllers();
    emit(state.copyWith(chewieController: null));
    final newVideoPlayerController = VideoPlayerController.networkUrl(
      _getUrl(episode: state.episodes[episodeNumber], host: state.host),
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
}
