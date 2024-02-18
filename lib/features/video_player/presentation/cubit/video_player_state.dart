// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_player_cubit.dart';

enum VideoPlayerStatus { loading, loaded }

class VideoPlayerState extends Equatable {
  final VideoPlayerStatus status;
  final int titleId;
  final Player player;
  final int currentEpisode;
  final VideoPlayerController videoPlayerController;
  final ChewieController? chewieController;
  final WatchedEpisode? watchedEpisode;
  const VideoPlayerState({
    required this.status,
    required this.titleId,
    required this.player,
    required this.currentEpisode,
    required this.videoPlayerController,
    this.chewieController,
    this.watchedEpisode,
  });

  @override
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
    Player? player,
    int? currentEpisode,
    List<Episode>? episodes,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
    WatchedEpisode? watchedEpisode,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      titleId: titleId ?? this.titleId,
      player: player ?? this.player,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      chewieController: chewieController ?? this.chewieController,
      watchedEpisode: watchedEpisode ?? this.watchedEpisode,
    );
  }
}
