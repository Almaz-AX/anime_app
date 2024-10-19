// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shikimori_anime.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShikimoriAnime _$ShikimoriAnimeFromJson(Map<String, dynamic> json) =>
    ShikimoriAnime(
      id: json['id'] as String,
      name: json['name'] as String,
      score: (json['score'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShikimoriAnimeToJson(ShikimoriAnime instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'score': instance.score,
    };
