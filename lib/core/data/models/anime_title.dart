// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'anime_title.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AnimeTitle {
  final int id;
  final String? code;
  final Names names;
  @JsonKey(fromJson: _parseFranchiseList)
  final List<Franchises>? franchises;
  final String? announce;
  final Status? status;
  final Posters posters;
  final int? updated;
  final int? lastChange;
  final TitleType? type;
  final List<String> genres;
  // team пропустил
  final Season? season;
  final String? description;
  final int? inFavorites;
  final Blocked? blocked;
  final Player? player;
  final Torrents? torrents;
  AnimeTitle({
    required this.id,
    this.code,
    required this.names,
    required this.franchises,
    this.announce,
    this.status,
    required this.posters,
    this.updated,
    this.lastChange,
    this.type,
    required this.genres,
    this.season,
    this.description,
    this.inFavorites,
    this.blocked,
    this.player,
    this.torrents,
  });

  static List<Franchises>? _parseFranchiseList(List<dynamic>? lists) {
    if (lists == null) {
      return null;
    }
    final rez = lists
        .map((e) => Franchises.fromJson(e as Map<String, dynamic>))
        .toList();
    return rez;
  }

  factory AnimeTitle.fromJson(Map<String, dynamic> json) =>
      _$AnimeTitleFromJson(json);
  toJson() => _$AnimeTitleToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Names {
  final String ru;
  final String en;
  Names({
    required this.ru,
    required this.en,
  });
  factory Names.fromJson(Map<String, dynamic> json) => _$NamesFromJson(json);
  toJson() => _$NamesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Franchises {
  final Franchise franchise;
  @JsonKey(fromJson: _parseReleaseList)
  final List<Release> releases;
  Franchises({
    required this.franchise,
    required this.releases,
  });
  static List<Release> _parseReleaseList(List<dynamic> lists) {
    final rez =
        lists.map((e) => Release.fromJson(e as Map<String, dynamic>)).toList();
    return rez;
  }

  factory Franchises.fromJson(Map<String, dynamic> json) =>
      _$FranchisesFromJson(json);

  toJson() => _$FranchisesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Franchise {
  final String id;
  final String name;
  Franchise({
    required this.id,
    required this.name,
  });

  factory Franchise.fromJson(Map<String, dynamic> json) =>
      _$FranchiseFromJson(json);

  Map<String, dynamic> toJson() => _$FranchiseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Release {
  final int id;
  final String code;
  final int ordinal;
  final Names names;
  Release({
    required this.id,
    required this.code,
    required this.ordinal,
    required this.names,
  });
  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Status {
  final String string;
  final int code;
  Status({
    required this.string,
    required this.code,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);
  toJson() => _$StatusToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Posters {
  final SmallPoster small;
  final MediumPoster medium;
  final OriginalPoster original;
  Posters({
    required this.small,
    required this.medium,
    required this.original,
  });
  factory Posters.fromJson(Map<String, dynamic> json) =>
      _$PostersFromJson(json);

  toJson() => _$PostersToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class SmallPoster {
  final String url;
  final dynamic rawBase64File;
  SmallPoster({
    required this.url,
    required this.rawBase64File,
  });
  factory SmallPoster.fromJson(Map<String, dynamic> json) =>
      _$SmallPosterFromJson(json);
  toJson() => _$SmallPosterToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class MediumPoster {
  final String url;
  final dynamic rawBase64File;
  MediumPoster({
    required this.url,
    required this.rawBase64File,
  });
  factory MediumPoster.fromJson(Map<String, dynamic> json) =>
      _$MediumPosterFromJson(json);
  toJson() => _$MediumPosterToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class OriginalPoster {
  final String url;
  final dynamic rawBase64File;
  OriginalPoster({
    required this.url,
    required this.rawBase64File,
  });
  factory OriginalPoster.fromJson(Map<String, dynamic> json) =>
      _$OriginalPosterFromJson(json);
  toJson() => _$OriginalPosterToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class TitleType {
  final String fullString;
  final int code;
  final String? string;
  final dynamic episodes;
  final String? lenght;
  TitleType({
    required this.fullString,
    required this.code,
    this.string,
    required this.episodes,
    this.lenght,
  });

  factory TitleType.fromJson(Map<String, dynamic> json) =>
      _$TitleTypeFromJson(json);
  toJson() => _$TitleTypeToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Season {
  final String? string;
  final int code;
  final int year;
  final int weekDay;
  Season({
    required this.string,
    required this.code,
    required this.year,
    required this.weekDay,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
  toJson() => _$SeasonToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Blocked {
  final bool? blocked;
  final bool? bakanim;
  Blocked({
    required this.blocked,
    required this.bakanim,
  });

  factory Blocked.fromJson(Map<String, dynamic> json) =>
      _$BlockedFromJson(json);
  toJson() => _$BlockedToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Player {
  final dynamic alternativePlayer;
  final String host;
  final Episodes episodes;
  @JsonKey(fromJson: _parseMapToList)
  final List<Episode> list;
  Player(
      {required this.alternativePlayer,
      required this.host,
      required this.episodes,
      required this.list});
  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);
  toJson() => _$PlayerToJson(this);

  static List<Episode> _parseMapToList(Map<dynamic, dynamic> map) {
    final list = map.values.toList();
    final rez =
        list.map((e) => Episode.fromJson(e as Map<String, dynamic>)).toList();
    return rez;
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Episodes {
  final int? first;
  final int? last;
  final String string;
  Episodes({
    this.first,
    this.last,
    required this.string,
  });

  factory Episodes.fromJson(Map<String, dynamic> json) =>
      _$EpisodesFromJson(json);
  toJson() => _$EpisodesToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Episode {
  final int episode;
  final String? name;
  final String uuid;
  final int createdTimestamp;
  final String? preview;
  final Skips skips;
  final Hls hls;
  Episode({
    required this.episode,
    this.name,
    required this.uuid,
    required this.createdTimestamp,
    required this.preview,
    required this.skips,
    required this.hls,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
  toJson() => _$EpisodeToJson(this);
}

@JsonSerializable()
class Skips {
  final List<int> opening;
  final List<int> ending;
  Skips({
    required this.opening,
    required this.ending,
  });
  factory Skips.fromJson(Map<String, dynamic> json) => _$SkipsFromJson(json);
  toJson() => _$SkipsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ProtocolList {
  final Hls hls;
  ProtocolList({
    required this.hls,
  });
  factory ProtocolList.fromJson(Map<String, dynamic> json) =>
      _$ProtocolListFromJson(json);
  toJson() => _$ProtocolListToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Hls {
  final String? fhd;
  final String? hd;
  final String sd;
  Hls({
    this.fhd,
    required this.hd,
    required this.sd,
  });

  factory Hls.fromJson(Map<String, dynamic> json) => _$HlsFromJson(json);
  toJson() => _$HlsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Torrents {
  final Episodes episodes;
  final List<Torrent> list;
  Torrents({
    required this.episodes,
    required this.list,
  });

  factory Torrents.fromJson(Map<String, dynamic> json) =>
      _$TorrentsFromJson(json);
  toJson() => _$TorrentsToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Torrent {
  final int torrentId;
  final Episodes episodes;
  final Quality quality;
  final int leechers;
  final int seeders;
  final int downloads;
  final int totalSize;
  final String sizeString;
  final String url;
  final String magnet;
  final int uploadedTimestamp;
  final String hash;
  final dynamic metadata;
  final dynamic rawBaseFile;
  Torrent({
    required this.torrentId,
    required this.episodes,
    required this.quality,
    required this.leechers,
    required this.seeders,
    required this.downloads,
    required this.totalSize,
    required this.sizeString,
    required this.url,
    required this.magnet,
    required this.uploadedTimestamp,
    required this.hash,
    required this.metadata,
    required this.rawBaseFile,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) =>
      _$TorrentFromJson(json);
  toJson() => _$TorrentToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Quality {
  final String string;
  final String type;
  final String resolution;
  final String encoder;
  final dynamic lqAudio;
  Quality({
    required this.string,
    required this.type,
    required this.resolution,
    required this.encoder,
    required this.lqAudio,
  });

  factory Quality.fromJson(Map<String, dynamic> json) =>
      _$QualityFromJson(json);
  toJson() => _$QualityToJson(this);
}
