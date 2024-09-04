// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'video_player_cubit.dart';

enum VideoPlayerStatus { loading, loaded }

class VideoPlayerState extends Equatable {
  final VideoPlayerStatus status;
  final EntryItem episode;
  final LinkedList<EntryItem> linkedEpisodes;
  final VideoPlayerController videoPlayerController;
  final WatchedEpisode? watchedEpisode;
  const VideoPlayerState({
    required this.status,
    required this.episode,
    required this.linkedEpisodes,
    required this.videoPlayerController,
    this.watchedEpisode,
  });

  @override
  List<Object?> get props => [status, videoPlayerController, watchedEpisode];

  VideoPlayerState copyWith({
    VideoPlayerStatus? status,
    EntryItem? episode,
    LinkedList<EntryItem>? linkedEpisodes,
    VideoPlayerController? videoPlayerController,
    WatchedEpisode? watchedEpisode,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      episode: episode ?? this.episode,
      linkedEpisodes: linkedEpisodes ?? this.linkedEpisodes,
      videoPlayerController:
          videoPlayerController ?? this.videoPlayerController,
      watchedEpisode: watchedEpisode ?? this.watchedEpisode,
    );
  }
}

final class EntryItem extends LinkedListEntry<EntryItem> {
  final int releaseId;
  final Episode episode;
  EntryItem({required this.releaseId, required this.episode});
}
