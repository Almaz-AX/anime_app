// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_title.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeTitle _$AnimeTitleFromJson(Map<String, dynamic> json) => AnimeTitle(
      id: json['id'] as int,
      code: json['code'] as String?,
      names: Names.fromJson(json['names'] as Map<String, dynamic>),
      franchises: AnimeTitle._parseFranchiseList(json['franchises'] as List?),
      announce: json['announce'] as String?,
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      posters: Posters.fromJson(json['posters'] as Map<String, dynamic>),
      updated: json['updated'] as int?,
      lastChange: json['last_change'] as int?,
      type: json['type'] == null
          ? null
          : TitleType.fromJson(json['type'] as Map<String, dynamic>),
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
      season: json['season'] == null
          ? null
          : Season.fromJson(json['season'] as Map<String, dynamic>),
      description: json['description'] as String?,
      inFavorites: json['in_favorites'] as int?,
      blocked: json['blocked'] == null
          ? null
          : Blocked.fromJson(json['blocked'] as Map<String, dynamic>),
      player: json['player'] == null
          ? null
          : Player.fromJson(json['player'] as Map<String, dynamic>),
      torrents: json['torrents'] == null
          ? null
          : Torrents.fromJson(json['torrents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnimeTitleToJson(AnimeTitle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'names': instance.names.toJson(),
      'franchises': instance.franchises?.map((e) => e.toJson()).toList(),
      'announce': instance.announce,
      'status': instance.status?.toJson(),
      'posters': instance.posters.toJson(),
      'updated': instance.updated,
      'last_change': instance.lastChange,
      'type': instance.type?.toJson(),
      'genres': instance.genres,
      'season': instance.season?.toJson(),
      'description': instance.description,
      'in_favorites': instance.inFavorites,
      'blocked': instance.blocked?.toJson(),
      'player': instance.player?.toJson(),
      'torrents': instance.torrents?.toJson(),
    };

Names _$NamesFromJson(Map<String, dynamic> json) => Names(
      ru: json['ru'] as String,
      en: json['en'] as String,
    );

Map<String, dynamic> _$NamesToJson(Names instance) => <String, dynamic>{
      'ru': instance.ru,
      'en': instance.en,
    };

Franchises _$FranchisesFromJson(Map<String, dynamic> json) => Franchises(
      franchise: Franchise.fromJson(json['franchise'] as Map<String, dynamic>),
      releases: Franchises._parseReleaseList(json['releases'] as List),
    );

Map<String, dynamic> _$FranchisesToJson(Franchises instance) =>
    <String, dynamic>{
      'franchise': instance.franchise.toJson(),
      'releases': instance.releases.map((e) => e.toJson()).toList(),
    };

Franchise _$FranchiseFromJson(Map<String, dynamic> json) => Franchise(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$FranchiseToJson(Franchise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Release _$ReleaseFromJson(Map<String, dynamic> json) => Release(
      id: json['id'] as int,
      code: json['code'] as String,
      ordinal: json['ordinal'] as int,
      names: Names.fromJson(json['names'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'ordinal': instance.ordinal,
      'names': instance.names.toJson(),
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      string: json['string'] as String,
      code: json['code'] as int,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'string': instance.string,
      'code': instance.code,
    };

Posters _$PostersFromJson(Map<String, dynamic> json) => Posters(
      small: SmallPoster.fromJson(json['small'] as Map<String, dynamic>),
      medium: MediumPoster.fromJson(json['medium'] as Map<String, dynamic>),
      original:
          OriginalPoster.fromJson(json['original'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostersToJson(Posters instance) => <String, dynamic>{
      'small': instance.small.toJson(),
      'medium': instance.medium.toJson(),
      'original': instance.original.toJson(),
    };

SmallPoster _$SmallPosterFromJson(Map<String, dynamic> json) => SmallPoster(
      url: json['url'] as String,
      rawBase64File: json['raw_base64_file'],
    );

Map<String, dynamic> _$SmallPosterToJson(SmallPoster instance) =>
    <String, dynamic>{
      'url': instance.url,
      'raw_base64_file': instance.rawBase64File,
    };

MediumPoster _$MediumPosterFromJson(Map<String, dynamic> json) => MediumPoster(
      url: json['url'] as String,
      rawBase64File: json['raw_base64_file'],
    );

Map<String, dynamic> _$MediumPosterToJson(MediumPoster instance) =>
    <String, dynamic>{
      'url': instance.url,
      'raw_base64_file': instance.rawBase64File,
    };

OriginalPoster _$OriginalPosterFromJson(Map<String, dynamic> json) =>
    OriginalPoster(
      url: json['url'] as String,
      rawBase64File: json['raw_base64_file'],
    );

Map<String, dynamic> _$OriginalPosterToJson(OriginalPoster instance) =>
    <String, dynamic>{
      'url': instance.url,
      'raw_base64_file': instance.rawBase64File,
    };

TitleType _$TitleTypeFromJson(Map<String, dynamic> json) => TitleType(
      fullString: json['full_string'] as String,
      code: json['code'] as int,
      string: json['string'] as String?,
      episodes: json['episodes'],
      lenght: json['lenght'] as String?,
    );

Map<String, dynamic> _$TitleTypeToJson(TitleType instance) => <String, dynamic>{
      'full_string': instance.fullString,
      'code': instance.code,
      'string': instance.string,
      'episodes': instance.episodes,
      'lenght': instance.lenght,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      string: json['string'] as String?,
      code: json['code'] as int,
      year: json['year'] as int,
      weekDay: json['week_day'] as int,
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      'string': instance.string,
      'code': instance.code,
      'year': instance.year,
      'week_day': instance.weekDay,
    };

Blocked _$BlockedFromJson(Map<String, dynamic> json) => Blocked(
      blocked: json['blocked'] as bool?,
      bakanim: json['bakanim'] as bool?,
    );

Map<String, dynamic> _$BlockedToJson(Blocked instance) => <String, dynamic>{
      'blocked': instance.blocked,
      'bakanim': instance.bakanim,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      alternativePlayer: json['alternative_player'],
      host: json['host'] as String,
      episodes: Episodes.fromJson(json['episodes'] as Map<String, dynamic>),
      list: Player._parseMapToList(json['list'] as Map),
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'alternative_player': instance.alternativePlayer,
      'host': instance.host,
      'episodes': instance.episodes.toJson(),
      'list': instance.list.map((e) => e.toJson()).toList(),
    };

Episodes _$EpisodesFromJson(Map<String, dynamic> json) => Episodes(
      first: json['first'] as int?,
      last: json['last'] as int?,
      string: json['string'] as String?,
    );

Map<String, dynamic> _$EpisodesToJson(Episodes instance) => <String, dynamic>{
      'first': instance.first,
      'last': instance.last,
      'string': instance.string,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      episode: json['episode'] as int,
      name: json['name'] as String?,
      uuid: json['uuid'] as String,
      createdTimestamp: json['created_timestamp'] as int,
      preview: json['preview'] as String?,
      skips: Skips.fromJson(json['skips'] as Map<String, dynamic>),
      hls: Hls.fromJson(json['hls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'episode': instance.episode,
      'name': instance.name,
      'uuid': instance.uuid,
      'created_timestamp': instance.createdTimestamp,
      'preview': instance.preview,
      'skips': instance.skips.toJson(),
      'hls': instance.hls.toJson(),
    };

Skips _$SkipsFromJson(Map<String, dynamic> json) => Skips(
      opening: (json['opening'] as List<dynamic>).map((e) => e as int).toList(),
      ending: (json['ending'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$SkipsToJson(Skips instance) => <String, dynamic>{
      'opening': instance.opening,
      'ending': instance.ending,
    };

ProtocolList _$ProtocolListFromJson(Map<String, dynamic> json) => ProtocolList(
      hls: Hls.fromJson(json['hls'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProtocolListToJson(ProtocolList instance) =>
    <String, dynamic>{
      'hls': instance.hls.toJson(),
    };

Hls _$HlsFromJson(Map<String, dynamic> json) => Hls(
      fhd: json['fhd'] as String?,
      hd: json['hd'] as String?,
      sd: json['sd'] as String,
    );

Map<String, dynamic> _$HlsToJson(Hls instance) => <String, dynamic>{
      'fhd': instance.fhd,
      'hd': instance.hd,
      'sd': instance.sd,
    };

Torrents _$TorrentsFromJson(Map<String, dynamic> json) => Torrents(
      episodes: Episodes.fromJson(json['episodes'] as Map<String, dynamic>),
      list: (json['list'] as List<dynamic>)
          .map((e) => Torrent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TorrentsToJson(Torrents instance) => <String, dynamic>{
      'episodes': instance.episodes.toJson(),
      'list': instance.list.map((e) => e.toJson()).toList(),
    };

Torrent _$TorrentFromJson(Map<String, dynamic> json) => Torrent(
      torrentId: json['torrent_id'] as int,
      episodes: Episodes.fromJson(json['episodes'] as Map<String, dynamic>),
      quality: Quality.fromJson(json['quality'] as Map<String, dynamic>),
      leechers: json['leechers'] as int,
      seeders: json['seeders'] as int,
      downloads: json['downloads'] as int,
      totalSize: json['total_size'] as int,
      sizeString: json['size_string'] as String,
      url: json['url'] as String,
      magnet: json['magnet'] as String,
      uploadedTimestamp: json['uploaded_timestamp'] as int,
      hash: json['hash'] as String,
      metadata: json['metadata'],
      rawBaseFile: json['raw_base_file'],
    );

Map<String, dynamic> _$TorrentToJson(Torrent instance) => <String, dynamic>{
      'torrent_id': instance.torrentId,
      'episodes': instance.episodes.toJson(),
      'quality': instance.quality.toJson(),
      'leechers': instance.leechers,
      'seeders': instance.seeders,
      'downloads': instance.downloads,
      'total_size': instance.totalSize,
      'size_string': instance.sizeString,
      'url': instance.url,
      'magnet': instance.magnet,
      'uploaded_timestamp': instance.uploadedTimestamp,
      'hash': instance.hash,
      'metadata': instance.metadata,
      'raw_base_file': instance.rawBaseFile,
    };

Quality _$QualityFromJson(Map<String, dynamic> json) => Quality(
      string: json['string'] as String,
      type: json['type'] as String,
      resolution: json['resolution'] as String?,
      encoder: json['encoder'] as String,
      lqAudio: json['lq_audio'],
    );

Map<String, dynamic> _$QualityToJson(Quality instance) => <String, dynamic>{
      'string': instance.string,
      'type': instance.type,
      'resolution': instance.resolution,
      'encoder': instance.encoder,
      'lq_audio': instance.lqAudio,
    };
