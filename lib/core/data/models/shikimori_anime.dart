// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'shikimori_anime.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ShikimoriAnime {
  final String id;
  final String name;
  final double? score;
  final AnimeStatus? status;
  ShikimoriAnime({
    required this.id,
    required this.name,
    this.score,
    this.status,
  });

  factory ShikimoriAnime.fromJson(Map<String, dynamic> json) =>
      _$ShikimoriAnimeFromJson(json);

  toJson() => _$ShikimoriAnimeToJson(this);
}

enum AnimeStatus{
  anons,
  ongoing,
  released
}