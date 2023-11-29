import 'package:anime_app/core/data/local/DAO/watched_episode_dao.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

abstract class GetWatchedEpisodesLocalDataSource {
  Stream<List<WatchedEpisode>> getWatchedEpisodes(int id);
}

class GetWatchedEpisodesLocalDataSourceImpl
    implements GetWatchedEpisodesLocalDataSource {
  final WatchedEpisodesDAO watchedEpisodesDAO;

  GetWatchedEpisodesLocalDataSourceImpl({required this.watchedEpisodesDAO});
  @override
  Stream<List<WatchedEpisode>> getWatchedEpisodes(int id) {
    watchedEpisodesDAO
        .getWatchedEpisodes(id)
        .then((value) => watchedEpisodesDAO.controller.sink.add(value));
    return watchedEpisodesDAO.getEpisodesAsStream(id);
  }
}
