// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_title_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeTitleDb _$AnimeTitleDbFromJson(Map<String, dynamic> json) => AnimeTitleDb(
      id: json['title_id'] as int,
      titleName: json['title_name'] as String,
      watchedEpisode: (json['watched_episode'] as List<dynamic>)
          .map((e) => WatchedEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnimeTitleDbToJson(AnimeTitleDb instance) =>
    <String, dynamic>{
      'title_id': instance.id,
      'title_name': instance.titleName,
      'watched_episode':
          instance.watchedEpisode.map((e) => e.toJson()).toList(),
    };
