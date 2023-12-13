// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_player_cubit.dart';

enum VideoPlayerStatus { loading, loaded }

class VideoPlayerState extends Equatable {
  final VideoPlayerStatus status;
  final int titleId;
  final String host;
  final int currentEpisode;
  final List<Episode> episodes;
  final VideoPlayerController videoPlayerController;
  final ChewieController? chewieController;
  final WatchedEpisode? watchedEpisode;
  VideoPlayerState({
    required this.status,
    required this.titleId,
    required this.host,
    required this.currentEpisode,
    required this.episodes,
    required this.videoPlayerController,
    this.chewieController,
    this.watchedEpisode,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        currentEpisode,
        videoPlayerController,
        chewieController,
        watchedEpisode
      ];

  VideoPlayerState copyWith({
    VideoPlayerStatus? status,
    int? titleId,
    String? host,
    int? currentEpisode,
    List<Episode>? episodes,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
    WatchedEpisode? watchedEpisode,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      titleId: titleId ?? this.titleId,
      host: host ?? this.host,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      episodes: episodes ?? this.episodes,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      chewieController: chewieController ?? this.chewieController,
      watchedEpisode: watchedEpisode ?? this.watchedEpisode,
    );
  }
}
