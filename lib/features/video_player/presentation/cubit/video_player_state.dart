// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_player_cubit.dart';
abstract class VideoPlayerState extends Equatable{}

class VideoPlayerChengedEpisodeState extends VideoPlayerState {
  final int titleId;
  final String host;
  final int currentEpisode;
  final List<Episode> episodes;
  final VideoPlayerController videoPlayerController;
  final ChewieController? chewieController;

  VideoPlayerChengedEpisodeState(
      {required this.titleId,
      required this.host,
      required this.currentEpisode,
      required this.episodes,
      required this.videoPlayerController,
      this.chewieController});

  VideoPlayerChengedEpisodeState copyWith({
    int? titleId,
    String? host,
    int? currentEpisode,
    List<Episode>? episodes,
    VideoPlayerController? videoPlayerController,
    ChewieController? chewieController,
  }) {
    return VideoPlayerChengedEpisodeState(
      titleId: titleId ?? this.titleId,
      host: host ?? this.host,
      currentEpisode: currentEpisode ?? this.currentEpisode,
      episodes: episodes ?? this.episodes,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      chewieController: chewieController ?? this.chewieController,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [host, currentEpisode, videoPlayerController, chewieController];
}
