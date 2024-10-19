// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Release _$ReleaseFromJson(Map<String, dynamic> json) => Release(
      id: (json['id'] as num).toInt(),
      type: ReleaseType.fromJson(json['type'] as Map<String, dynamic>),
      year: (json['year'] as num).toInt(),
      name: Name.fromJson(json['name'] as Map<String, dynamic>),
      alias: json['alias'] as String,
      season: Season.fromJson(json['season'] as Map<String, dynamic>),
      poster: Poster.fromJson(json['poster'] as Map<String, dynamic>),
      freshAt: json['fresh_at'] == null
          ? null
          : DateTime.parse(json['fresh_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isOngoing: json['is_ongoing'] as bool,
      ageRating: AgeRating.fromJson(json['age_rating'] as Map<String, dynamic>),
      publishDay:
          PublishDay.fromJson(json['publish_day'] as Map<String, dynamic>),
      description: json['description'] as String?,
      notification: json['notification'] as String?,
      episodesTotal: (json['episodes_total'] as num?)?.toInt(),
      externalPlayer: json['external_player'] as String?,
      isInProduction: json['is_in_production'] as bool,
      isBlockedByGeo: json['is_blocked_by_geo'] as bool,
      episodesAreUnknown: json['episodes_are_unknown'] as bool,
      isBlockedByCopyrights: json['is_blocked_by_copyrights'] as bool,
      addedInUsersFavorites: (json['added_in_users_favorites'] as num).toInt(),
      averageDurationOfEpisode:
          (json['average_duration_of_episode'] as num?)?.toInt(),
      genres: Release._parseListGenre(json['genres'] as List?),
      members: Release._parseListMember(json['members'] as List?),
      sponsor: json['sponsor'],
      episodes: Release._parseListEpisode(json['episodes'] as List?),
      torrents: Release._parseListTorrent(json['torrents'] as List?),
    );

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type.toJson(),
      'year': instance.year,
      'name': instance.name.toJson(),
      'alias': instance.alias,
      'season': instance.season.toJson(),
      'poster': instance.poster.toJson(),
      'fresh_at': instance.freshAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_ongoing': instance.isOngoing,
      'age_rating': instance.ageRating.toJson(),
      'publish_day': instance.publishDay.toJson(),
      'description': instance.description,
      'notification': instance.notification,
      'episodes_total': instance.episodesTotal,
      'external_player': instance.externalPlayer,
      'is_in_production': instance.isInProduction,
      'is_blocked_by_geo': instance.isBlockedByGeo,
      'episodes_are_unknown': instance.episodesAreUnknown,
      'is_blocked_by_copyrights': instance.isBlockedByCopyrights,
      'added_in_users_favorites': instance.addedInUsersFavorites,
      'average_duration_of_episode': instance.averageDurationOfEpisode,
      'genres': instance.genres?.map((e) => e.toJson()).toList(),
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'sponsor': instance.sponsor,
      'episodes': instance.episodes?.map((e) => e.toJson()).toList(),
      'torrents': instance.torrents?.map((e) => e.toJson()).toList(),
    };

ReleaseType _$ReleaseTypeFromJson(Map<String, dynamic> json) => ReleaseType(
      value: json['value'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ReleaseTypeToJson(ReleaseType instance) =>
    <String, dynamic>{
      'value': instance.value,
      'description': instance.description,
    };

Name _$NameFromJson(Map<String, dynamic> json) => Name(
      main: json['main'] as String,
      english: json['english'] as String,
      alternative: json['alternative'] as String?,
    );

Map<String, dynamic> _$NameToJson(Name instance) => <String, dynamic>{
      'main': instance.main,
      'english': instance.english,
      'alternative': instance.alternative,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      value: json['value'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'value': instance.value,
      'description': instance.description,
    };

Poster _$PosterFromJson(Map<String, dynamic> json) => Poster(
      src: json['src'] as String,
      thumbnail: json['thumbnail'] as String,
      optimized: json['optimized'] == null
          ? null
          : Optimized.fromJson(json['optimized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PosterToJson(Poster instance) => <String, dynamic>{
      'src': instance.src,
      'thumbnail': instance.thumbnail,
      'optimized': instance.optimized?.toJson(),
    };

Optimized _$OptimizedFromJson(Map<String, dynamic> json) => Optimized(
      src: json['src'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$OptimizedToJson(Optimized instance) => <String, dynamic>{
      'src': instance.src,
      'thumbnail': instance.thumbnail,
    };

AgeRating _$AgeRatingFromJson(Map<String, dynamic> json) => AgeRating(
      value: json['value'] as String,
      label: json['label'] as String,
      isAdult: json['is_adult'] as bool,
      description: json['description'] as String,
    );

Map<String, dynamic> _$AgeRatingToJson(AgeRating instance) => <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'is_adult': instance.isAdult,
      'description': instance.description,
    };

PublishDay _$PublishDayFromJson(Map<String, dynamic> json) => PublishDay(
      value: (json['value'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$PublishDayToJson(PublishDay instance) =>
    <String, dynamic>{
      'value': instance.value,
      'description': instance.description,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      image: GenreImage.fromJson(json['image'] as Map<String, dynamic>),
      totalReleases: (json['total_releases'] as num).toInt(),
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'total_releases': instance.totalReleases,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      id: json['id'] as String,
      role: Season.fromJson(json['role'] as Map<String, dynamic>),
      nickname: json['nickname'] as String,
      user: json['user'],
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'nickname': instance.nickname,
      'user': instance.user,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      id: json['id'] as String,
      name: json['name'] as String?,
      ordinal: (json['ordinal'] as num).toInt(),
      opening: json['opening'] == null
          ? null
          : Ing.fromJson(json['opening'] as Map<String, dynamic>),
      ending: json['ending'] == null
          ? null
          : Ing.fromJson(json['ending'] as Map<String, dynamic>),
      preview: json['preview'] == null
          ? null
          : Preview.fromJson(json['preview'] as Map<String, dynamic>),
      hls480: json['hls_480'] as String,
      hls720: json['hls_720'] as String?,
      hls1080: json['hls_1080'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      rutubeId: json['rutube_id'] as String?,
      youtubeId: json['youtube_id'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      nameEnglish: json['name_english'] as String?,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ordinal': instance.ordinal,
      'opening': instance.opening?.toJson(),
      'ending': instance.ending?.toJson(),
      'preview': instance.preview?.toJson(),
      'hls_480': instance.hls480,
      'hls_720': instance.hls720,
      'hls_1080': instance.hls1080,
      'duration': instance.duration,
      'rutube_id': instance.rutubeId,
      'youtube_id': instance.youtubeId,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'sort_order': instance.sortOrder,
      'name_english': instance.nameEnglish,
    };

Ing _$IngFromJson(Map<String, dynamic> json) => Ing(
      stop: (json['stop'] as num?)?.toInt(),
      start: (json['start'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IngToJson(Ing instance) => <String, dynamic>{
      'stop': instance.stop,
      'start': instance.start,
    };

Preview _$PreviewFromJson(Map<String, dynamic> json) => Preview(
      src: json['src'] as String?,
      thumbnail: json['thumbnail'] as String?,
      optimized: json['optimized'] == null
          ? null
          : Optimized.fromJson(json['optimized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PreviewToJson(Preview instance) => <String, dynamic>{
      'src': instance.src,
      'thumbnail': instance.thumbnail,
      'optimized': instance.optimized?.toJson(),
    };

GenreImage _$GenreImageFromJson(Map<String, dynamic> json) => GenreImage(
      preview: json['preview'] as String,
      thumbnail: json['thumbnail'] as String,
      optimized: json['optimized'] == null
          ? null
          : Optimized.fromJson(json['optimized'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GenreImageToJson(GenreImage instance) =>
    <String, dynamic>{
      'preview': instance.preview,
      'thumbnail': instance.thumbnail,
      'optimized': instance.optimized,
    };

Torrent _$TorrentFromJson(Map<String, dynamic> json) => Torrent(
      id: (json['id'] as num).toInt(),
      hash: json['hash'] as String,
      size: (json['size'] as num).toInt(),
      type: Season.fromJson(json['type'] as Map<String, dynamic>),
      label: json['label'] as String,
      codec: Season.fromJson(json['codec'] as Map<String, dynamic>),
      color: json['color'] == null
          ? null
          : Season.fromJson(json['color'] as Map<String, dynamic>),
      magnet: json['magnet'] as String,
      seeders: (json['seeders'] as num).toInt(),
      quality: Season.fromJson(json['quality'] as Map<String, dynamic>),
      bitrate: (json['bitrate'] as num?)?.toInt(),
      filename: json['filename'] as String?,
      leechers: (json['leechers'] as num).toInt(),
      sortOrder: (json['sort_order'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      description: json['description'] as String,
      completedTimes: (json['completed_times'] as num).toInt(),
    );

Map<String, dynamic> _$TorrentToJson(Torrent instance) => <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'size': instance.size,
      'type': instance.type.toJson(),
      'label': instance.label,
      'codec': instance.codec.toJson(),
      'color': instance.color?.toJson(),
      'magnet': instance.magnet,
      'seeders': instance.seeders,
      'quality': instance.quality.toJson(),
      'bitrate': instance.bitrate,
      'filename': instance.filename,
      'leechers': instance.leechers,
      'sort_order': instance.sortOrder,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'description': instance.description,
      'completed_times': instance.completedTimes,
    };
