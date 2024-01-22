// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:anime_app/core/data/models/anime_title.dart';

part 'title_updates.g.dart';

@JsonSerializable()
class TitleUpdates {
  @JsonKey(fromJson: _parseTitleList)
  final List<AnimeTitle> list;
  final Pagination pagination;
  TitleUpdates({
    required this.list,
    required this.pagination,
  });

  static List<AnimeTitle> _parseTitleList(List<dynamic> lists) {
    final rez = lists
        .map((e) => AnimeTitle.fromJson(e as Map<String, dynamic>))
        .toList();
    return rez;
  }

  factory TitleUpdates.fromJson(Map<String, dynamic> json) =>
      _$TitleUpdatesFromJson(json);
  toJson() => _$TitleUpdatesToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Pagination {
  final int pages;
  final int currentPage;
  final int itemsPerPage;
  final int totalItems;
  Pagination({
    required this.pages,
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalItems,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
  toJson() => _$PaginationToJson(this);
}
