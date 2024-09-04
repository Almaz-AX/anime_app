// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchedEpisode _$WatchedEpisodeFromJson(Map<String, dynamic> json) =>
    WatchedEpisode(
      episodeNumber: json['episode_number'] as int,
      watchCompleted: json['watch_completed'] == null
          ? false
          : WatchedEpisode._parseToBool(json['watch_completed']),
      continueTimestamp: json['continue_timestamp'] as int? ?? 0,
      releaseId: json['release_id'] as int,
      updatedTime: json['updated_time'] as int,
    );

Map<String, dynamic> _$WatchedEpisodeToJson(WatchedEpisode instance) =>
    <String, dynamic>{
      'episode_number': instance.episodeNumber,
      'updated_time': instance.updatedTime,
      'watch_completed': instance.watchCompleted,
      'continue_timestamp': instance.continueTimestamp,
      'release_id': instance.releaseId,
    };
