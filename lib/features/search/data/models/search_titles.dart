import 'package:anime_app/features/home/data/models/title_updates.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:anime_app/core/data/models/anime_title.dart';

part 'search_titles.g.dart';

@JsonSerializable()
class SearchTitles {
  @JsonKey(fromJson: _parseTitleList)
  final List<AnimeTitle> list;
  final Pagination pagination;
  SearchTitles({
    required this.list,
    required this.pagination,
  });

  static List<AnimeTitle> _parseTitleList(List<dynamic> lists) {
    final rez = lists
        .map((e) => AnimeTitle.fromJson(e as Map<String, dynamic>))
        .toList();
    return rez;
  }

  factory SearchTitles.fromJson(Map<String, dynamic> json) =>
      _$SearchTitlesFromJson(json);
  toJson() => _$SearchTitlesToJson(this);
}
