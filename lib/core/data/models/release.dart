// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'release.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Release {
  final int id;
  final ReleaseType type;
  final int year;
  final Name name;
  final String alias;
  final Season season;
  final Poster poster;
  final DateTime? freshAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isOngoing;
  final AgeRating ageRating;
  final PublishDay publishDay;
  final String? description;
  final String? notification;
  final int? episodesTotal;
  final String? externalPlayer;
  final bool isInProduction;
  final bool isBlockedByGeo;
  final bool episodesAreUnknown;
  final bool isBlockedByCopyrights;
  final int addedInUsersFavorites;
  final int? averageDurationOfEpisode;
  @JsonKey(fromJson: _parseListGenre)
  final List<Genre>? genres;
   @JsonKey(fromJson:  _parseListMember)
  final List<Member>? members;
  final dynamic sponsor;
  @JsonKey(fromJson: _parseListEpisode)
  final List<Episode>? episodes;
  @JsonKey(fromJson: _parseListTorrent)
  final List<Torrent>? torrents;

  Release({
    required this.id,
    required this.type,
    required this.year,
    required this.name,
    required this.alias,
    required this.season,
    required this.poster,
    this.freshAt,
    this.createdAt,
    this.updatedAt,
    required this.isOngoing,
    required this.ageRating,
    required this.publishDay,
    this.description,
    this.notification,
    this.episodesTotal,
    this.externalPlayer,
    required this.isInProduction,
    required this.isBlockedByGeo,
    required this.episodesAreUnknown,
    required this.isBlockedByCopyrights,
    required this.addedInUsersFavorites,
    this.averageDurationOfEpisode,
    this.genres,
    this.members,
    this.sponsor,
    required this.episodes,
    this.torrents,
  });

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  toJson() => _$ReleaseToJson(this);


  static List<Genre>? _parseListGenre(List<dynamic>? list) {
    return list
            ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
            .toList();
  }

  static List<Episode>? _parseListEpisode(List<dynamic>? list) {
    return list
        ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<Torrent>? _parseListTorrent(List<dynamic>? list) {
    return list
        ?.map((e) => Torrent.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<Member>? _parseListMember(List<dynamic>? list) {
    return list
        ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
        .toList();
  }
  
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReleaseType {
  final String? value;
  final String? description;
  ReleaseType({
    required this.value,
    required this.description,
  });

  factory ReleaseType.fromJson(Map<String, dynamic> json) =>
      _$ReleaseTypeFromJson(json);

  toJson() => _$ReleaseTypeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Name {
  final String main;
  final String english;
  final String? alternative;

  Name({
    required this.main,
    required this.english,
    this.alternative,
  });

  factory Name.fromJson(Map<String, dynamic> json) => _$NameFromJson(json);

  toJson() => _$NameToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Season {
  final String? value;
  final String? description;

  Season({
    this.value,
    this.description,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  toJson() => _$SeasonToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Poster {
  final String src;
  final String thumbnail;
  final Optimized? optimized;

  Poster({
    required this.src,
    required this.thumbnail,
    this.optimized,
  });

  factory Poster.fromJson(Map<String, dynamic> json) => _$PosterFromJson(json);

  toJson() => _$PosterToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Optimized {
  final String? src;
  final String? thumbnail;

  Optimized({
    this.src,
    this.thumbnail,
  });

  factory Optimized.fromJson(Map<String, dynamic> json) =>
      _$OptimizedFromJson(json);

  toJson() => _$OptimizedToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class AgeRating {
  final String value;
  final String label;
  final bool isAdult;
  final String description;

  AgeRating({
    required this.value,
    required this.label,
    required this.isAdult,
    required this.description,
  });

  factory AgeRating.fromJson(Map<String, dynamic> json) =>
      _$AgeRatingFromJson(json);

  toJson() => _$AgeRatingToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PublishDay {
  final int value;
  final String description;

  PublishDay({
    required this.value,
    required this.description,
  });

  factory PublishDay.fromJson(Map<String, dynamic> json) =>
      _$PublishDayFromJson(json);

  toJson() => _$PublishDayToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  final int id;
  final String name;
  final GenreImage image;
  final int totalReleases;

  Genre({
    required this.id,
    required this.name,
    required this.image,
    required this.totalReleases,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  toJson() => _$GenreToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Member {
  final String id;
  final Season role;
  final String nickname;
  final dynamic user;

  Member({
    required this.id,
    required this.role,
    required this.nickname,
    this.user,
  });

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  toJson() => _$MemberToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Episode {
  final String id;
  final String? name;
  final int ordinal;
  final Ing? opening;
  final Ing? ending;
  final Preview? preview;
  @JsonKey(name: 'hls_480')
  final String hls480;
  @JsonKey(name: 'hls_720')
  final String? hls720;
  @JsonKey(name: 'hls_1080')
  final String? hls1080;
  final int? duration;
  final String? rutubeId;
  final String? youtubeId;
  final DateTime? updatedAt;
  final int? sortOrder;
  final String? nameEnglish;

  Episode({
    required this.id,
    this.name,
    required this.ordinal,
    this.opening,
    this.ending,
    this.preview,
    required this.hls480,
    this.hls720,
    this.hls1080,
    this.duration,
    this.rutubeId,
    this.youtubeId,
    this.updatedAt,
    this.sortOrder,
    this.nameEnglish,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  toJson() => _$EpisodeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ing {
  final int? stop;
  final int? start;

  Ing({
    this.stop,
    this.start,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => _$IngFromJson(json);
  toJson() => _$IngToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Preview {
  final String? src;
  final String? thumbnail;
  final Optimized? optimized;
  Preview({
    this.src,
    this.thumbnail,
    this.optimized,
  });

  factory Preview.fromJson(Map<String, dynamic> json) =>
      _$PreviewFromJson(json);
  toJson() => _$PreviewToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class GenreImage {
  final String preview;
  final String thumbnail;
  final Optimized? optimized;

  GenreImage({
    required this.preview,
    required this.thumbnail,
    this.optimized,
  });

  factory GenreImage.fromJson(Map<String, dynamic> json) =>
      _$GenreImageFromJson(json);
  toJson() => _$GenreImageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Torrent {
  final int id;
  final String hash;
  final int size;
  final Season type;
  final String label;
  final Season codec;
  final Season? color;
  final String magnet;
  final int seeders;
  final Season quality;
  final int? bitrate;
  final String? filename;
  final int leechers;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;
  final int completedTimes;

  Torrent({
    required this.id,
    required this.hash,
    required this.size,
    required this.type,
    required this.label,
    required this.codec,
    this.color,
    required this.magnet,
    required this.seeders,
    required this.quality,
    this.bitrate,
    required this.filename,
    required this.leechers,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
    required this.completedTimes,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) =>
      _$TorrentFromJson(json);
  toJson() => _$TorrentToJson(this);
}
