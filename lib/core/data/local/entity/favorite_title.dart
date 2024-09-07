// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_app/core/data/local/entity/base_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'favorite_title.g.dart';

@JsonSerializable()
class FavoriteTitle extends BaseEntity {
  static const tableName = 'FavoriteTitle';
  static const fieldAnimeTitleId = 'title_id';

  @JsonKey(name: fieldAnimeTitleId)
  final int releaseId;

  FavoriteTitle({
    required this.releaseId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [releaseId];

  Map<String, dynamic> toJson() => _$FavoriteTitleToJson(this);

  factory FavoriteTitle.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTitleFromJson(json);
}
