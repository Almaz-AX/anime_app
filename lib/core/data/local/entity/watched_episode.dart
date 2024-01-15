import 'package:json_annotation/json_annotation.dart';

import 'anime_title_db.dart';

part 'watched_episode.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WatchedEpisode extends BaseEntity {
  static const tableName = 'WatchedEpisode';
  static const fieldEpisodeNumber = 'episode_number';
  static const fieldWatchCompleted = 'watch_completed';
  static const fieldContinueTimestamp = 'continue_timestamp';
  static const fieldAnimeTitleId = 'title_id';
  static const fieldUpdatedTime = 'updated_time';

  @JsonKey(name: fieldEpisodeNumber)
  final int episodeNumber;

  @JsonKey(name: fieldUpdatedTime)
  final int updatedTime;

  @JsonKey(name: fieldWatchCompleted, fromJson: _parseToBool)
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
    required this.updatedTime,
  });

  static bool _parseToBool(dynamic value) => value == 1;

  Map<String, dynamic> toJson() => _$WatchedEpisodeToJson(this);

  factory WatchedEpisode.fromJson(Map<String, dynamic> json) =>
      _$WatchedEpisodeFromJson(json);

  @override
  List<Object?> get props => [
        episodeNumber,
        animeTitleId,
      ];
}
