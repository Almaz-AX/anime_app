import 'dart:async';

import 'package:anime_app/core/data/local/DAO/watched_episode_dao.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

abstract class GetWatchedEpisodesLocalDataSource {
  Stream<List<WatchedEpisode>> getWatchedEpisodes(int id);
}

class GetWatchedEpisodesLocalDataSourceImpl
    implements GetWatchedEpisodesLocalDataSource {
  final WatchedEpisodesDAO watchedEpisodesDAO;
  late StreamController<List<WatchedEpisode>> controller;

  GetWatchedEpisodesLocalDataSourceImpl({required this.watchedEpisodesDAO}) {
    controller = watchedEpisodesDAO.watchedEpisodeController;
  }
  @override
  Stream<List<WatchedEpisode>> getWatchedEpisodes(int id) {
    watchedEpisodesDAO
        .getWatchedEpisodesByTitle(id)
        .then((value) => controller.sink.add(value));
    return controller.stream;
  }
}
