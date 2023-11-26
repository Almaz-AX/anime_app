import 'package:anime_app/core/data/local/DAO/watched_episode_dao.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

abstract class GetWatchedEpisodesLocalDataSource {
  Future<Stream<List<WatchedEpisode>>> getWatchedEpisodes(int id);
}

class GetWatchedEpisodesLocalDataSourceImpl
    implements GetWatchedEpisodesLocalDataSource {
  final WatchedEpisodesDAO watchedEpisodesDAO;

  GetWatchedEpisodesLocalDataSourceImpl({required this.watchedEpisodesDAO});
  @override
  Future<Stream<List<WatchedEpisode>>> getWatchedEpisodes(int id) async {
    final watchedEpisodes = watchedEpisodesDAO.getEpisodesAsStream(id);
    return watchedEpisodes;
  }
}
