import 'dart:async';
import '../entity/watched_episode.dart';
import 'base_dao.dart';

class WatchedEpisodesDAO extends BaseDAO {
  Future<List<WatchedEpisode>> getWatchedEpisodesByReleaseId(
      int releaseId) async {
    final db = await getDB();
    List<Map<String, dynamic>> maps;
    maps = await db.query(
      WatchedEpisode.tableName,
      where: '${WatchedEpisode.fieldReleaseId} = $releaseId',
    );

    final watchedEpisodes =
        maps.map((e) => WatchedEpisode.fromJson(e)).toList();
    return watchedEpisodes;
  }

  Future<List<WatchedEpisode>> getUnderseenEpisodes() async {
    final db = await getDB();
    List<Map<String, dynamic>> maps;
    maps = await db.query(
      WatchedEpisode.tableName,
      where: '${WatchedEpisode.fieldWatchCompleted} = ${false}',
      orderBy: '${WatchedEpisode.fieldUpdatedTime} DESC',
      limit: 10,
    );
    final watchedEpisodes =
        maps.map((e) => WatchedEpisode.fromJson(e)).toList();
    return watchedEpisodes;
  }

  Future<void> changeWatchedEpisode(WatchedEpisode watchedEpisode) async {
    final watchedEpisodes =
        await getWatchedEpisodesByReleaseId(watchedEpisode.releaseId);
    if (watchedEpisodes.contains(watchedEpisode)) {
      await _updateWatchedEpisode(watchedEpisode);
    } else {
      await _addWatchedEpisode(watchedEpisode);
    }
    watchedEpisodeController
        .add(await getWatchedEpisodesByReleaseId(watchedEpisode.releaseId));

    watchedEpisodeHistoryController.add(await getUnderseenEpisodes());
  }

  Future<void> deleteWatchedEpisode(WatchedEpisode watchedEpisode) async {
    final db = await getDB();
    db.delete(
      WatchedEpisode.tableName,
      where: '${WatchedEpisode.fieldReleaseId} = ${watchedEpisode.releaseId}',
    );
    watchedEpisodeController
        .add((await getWatchedEpisodesByReleaseId(watchedEpisode.releaseId)));
  }

  Future<void> deleteWatchedEpisodes() async {
    final db = await getDB();
    db.delete(
      WatchedEpisode.tableName,
    );
  }

  Future<void> _addWatchedEpisode(WatchedEpisode watchedEpisode) async {
    final db = await getDB();
    db.insert(
      WatchedEpisode.tableName,
      watchedEpisode.toJson(),
    );
  }

  Future<void> _updateWatchedEpisode(WatchedEpisode watchedEpisode) async {
    final db = await getDB();
    db.update(WatchedEpisode.tableName, watchedEpisode.toJson(),
        where:
            '${WatchedEpisode.fieldReleaseId} = ${watchedEpisode.releaseId} AND ${WatchedEpisode.fieldEpisodeNumber} = ${watchedEpisode.episodeNumber}');
  }

  WatchedEpisodesDAO() {
    watchedEpisodeController =
        StreamController<List<WatchedEpisode>>.broadcast();
    watchedEpisodeHistoryController =
        StreamController<List<WatchedEpisode>>.broadcast();
  }

  late final StreamController<List<WatchedEpisode>>
      watchedEpisodeHistoryController;
  late final StreamController<List<WatchedEpisode>> watchedEpisodeController;

  Future<void> closeWatchedEpisodes() async {
    await watchedEpisodeController.close();
  }
}
