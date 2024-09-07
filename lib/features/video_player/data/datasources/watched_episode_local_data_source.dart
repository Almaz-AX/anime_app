// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/local/DAO/watched_episode_dao.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

abstract class WatchedEpisodeLocalDataSource {
  Future<void> saveEpisode(WatchedEpisode episode);

  Future<List<WatchedEpisode>> getEpisodes(int titleId);

  Future<List<WatchedEpisode>> getAllUnderseenEpisodes();
}

class WatchedEpisodeLocalDataSourceImpl extends WatchedEpisodeLocalDataSource {
  final WatchedEpisodesDAO watchedEpisodesDAO;
  WatchedEpisodeLocalDataSourceImpl({
    required this.watchedEpisodesDAO,
  });
  @override
  Future<void> saveEpisode(WatchedEpisode episode) async {
    return await watchedEpisodesDAO.changeWatchedEpisode(episode);
  }

  @override
  Future<List<WatchedEpisode>> getEpisodes(int titleId) async {
    return await watchedEpisodesDAO.getWatchedEpisodesByReleaseId(titleId);
  }

  @override
  Future<List<WatchedEpisode>> getAllUnderseenEpisodes() {
    return watchedEpisodesDAO.getUnderseenEpisodes();
  }
}
