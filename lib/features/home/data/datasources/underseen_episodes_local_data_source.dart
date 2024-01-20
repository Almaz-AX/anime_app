import 'dart:async';

import '../../../../core/data/local/DAO/watched_episode_dao.dart';
import '../../../../core/data/local/entity/watched_episode.dart';

abstract class UnderseenEpisodesLocalDataSource {
  Stream<List<WatchedEpisode>> listenUnderseenEpisodesHistory();
  Future<void> completeWatching(WatchedEpisode episode);
}

class UnderseenEpisodesLocalDataSourceImpl
    implements UnderseenEpisodesLocalDataSource {
  late final StreamController<List<WatchedEpisode>> controller;
  final WatchedEpisodesDAO local;
  UnderseenEpisodesLocalDataSourceImpl({required this.local}) {
    controller = local.watchedEpisodeHistoryController;
  }

  @override
  Stream<List<WatchedEpisode>> listenUnderseenEpisodesHistory() {
    local.getUnderseenEpisodes().then((value) => controller.add(value));
    return controller.stream;
  }

  @override
  Future<void> completeWatching(episode) async {
    await local.changeWatchedEpisode(episode.copyWith(watchCompleted: true));
  }
}
