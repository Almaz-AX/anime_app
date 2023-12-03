// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/local/DAO/watched_episode_dao.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

abstract class SaveEpisodeLocalDataSource {
  Future<void> saveEpisode(WatchedEpisode episode);
}

class SaveEpisodeLocalDataSourceImpl extends SaveEpisodeLocalDataSource {
  final WatchedEpisodesDAO watchedEpisodesDAO;
  SaveEpisodeLocalDataSourceImpl({
    required this.watchedEpisodesDAO,
  });
  @override
  Future<void> saveEpisode(WatchedEpisode episode) {
    // TODO: implement saveEpisode
    return watchedEpisodesDAO.changeWatchedEpisode(episode);
  }
}
