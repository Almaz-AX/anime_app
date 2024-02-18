import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'watched_episode.dart';

part 'anime_title_db.g.dart';

abstract class BaseEntity extends Equatable {}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class AnimeTitleDb extends BaseEntity {
  static const tableName = 'AnimeTitleDb';
  static const fieldId = 'title_id';
  static const fieldTitleName = 'title_name';
  static const fieldWatchedEpisode = 'watched_episode';

  @JsonKey(name: fieldId)
  final int id;

  @JsonKey(name: fieldTitleName)
  final String titleName;

  @JsonKey(name: fieldWatchedEpisode)
  final List<WatchedEpisode> watchedEpisode;

  AnimeTitleDb({
    required this.id,
    required this.titleName,
    required this.watchedEpisode,
  });

  Map<String, dynamic> toJson() => _$AnimeTitleDbToJson(this);

  factory AnimeTitleDb.fromJson(Map<String, dynamic> json) =>
      _$AnimeTitleDbFromJson(json);

  @override
  List<Object?> get props => [id, titleName, watchedEpisode];
}
