// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:anime_app/core/data/local/entity/base_entity.dart';

class FavoriteTitle extends BaseEntity {
  static const tableName = 'FavoriteTitle';
  static const fieldAnimeTitleId = 'title_id';
  final int animeTitleId;

  FavoriteTitle({
    required this.animeTitleId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [animeTitleId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      fieldAnimeTitleId: animeTitleId,
    };
  }

  factory FavoriteTitle.fromMap(Map<String, dynamic> map) {
    return FavoriteTitle(
      animeTitleId: map[fieldAnimeTitleId] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteTitle.fromJson(String source) =>
      FavoriteTitle.fromMap(json.decode(source) as Map<String, dynamic>);
}
