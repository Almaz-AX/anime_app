// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watched_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WatchedEpisode _$WatchedEpisodeFromJson(Map<String, dynamic> json) =>
    WatchedEpisode(
      episodeNumber: json['episode_number'] as int,
      watchCompleted: json['watch_completed'] as bool? ?? false,
      continueTimestamp: json['continue_timestamp'] as int? ?? 0,
      animeTitleId: json['title_id'] as int,
    );

Map<String, dynamic> _$WatchedEpisodeToJson(WatchedEpisode instance) =>
    <String, dynamic>{
      'episode_number': instance.episodeNumber,
      'watch_completed': instance.watchCompleted,
      'continue_timestamp': instance.continueTimestamp,
      'title_id': instance.animeTitleId,
    };
