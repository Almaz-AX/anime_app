import 'package:json_annotation/json_annotation.dart';

part 'watched_episode.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WatchedEpisode {
  static const tableName = 'WatchedEpisode';
  static const fieldEpisodeNumber = 'episode_number';
  static const fieldWatchCompleted = 'watch_completed';
  static const fieldContinueTimestamp = 'continue_timestamp';
  static const fieldAnimeTitleId = 'title_id';
  
  @JsonKey(name: fieldEpisodeNumber)
  final int episodeNumber;

  @JsonKey(name: fieldWatchCompleted)
  final bool watchCompleted;

  @JsonKey(name: fieldContinueTimestamp)
  final int continueTimestamp;

  @JsonKey(name: fieldAnimeTitleId)
  final int animeTitleId;

  WatchedEpisode({
    required this.episodeNumber,
    this.watchCompleted = false,
    this.continueTimestamp = 0,
    required this.animeTitleId,
  });

  Map<String, dynamic> toJson() => _$WatchedEpisodeToJson(this);

  factory WatchedEpisode.fromJson(Map<String, dynamic> json) =>
      _$WatchedEpisodeFromJson(json);
}
