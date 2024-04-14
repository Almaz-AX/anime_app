// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/local/entity/base_entity.dart';

import 'favorite_title.dart';

import 'watched_episode.dart';

class AnimeTitleDb extends BaseEntity {
  static const tableName = 'AnimeTitleDb';
  static const fieldId = 'title_id';
  static const fieldTitleName = 'title_name';
  static const fieldWatchedEpisode = 'watched_episode';
  static const fieldInFavorites = 'in_favorites';

  final int id;
  final String titleName;
  final List<WatchedEpisode>? watchedEpisode;
  final FavoriteTitle? inFavorites;

  AnimeTitleDb({
    required this.id,
    required this.titleName,
    this.watchedEpisode,
    this.inFavorites,
  });

  @override
  List<Object?> get props => [id, titleName, watchedEpisode];
}
