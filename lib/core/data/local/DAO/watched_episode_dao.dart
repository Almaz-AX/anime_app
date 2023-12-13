import 'dart:async';

import '../entity/watched_episode.dart';
import 'base_dao.dart';

class WatchedEpisodesDAO extends BaseDAO {
  Future<List<WatchedEpisode>> getWatchedEpisodes(int? titleId) async {
    final db = await getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      WatchedEpisode.tableName,
      where: '${WatchedEpisode.fieldAnimeTitleId} = $titleId',
    );
    final watchedEpisodes =
        maps.map((e) => WatchedEpisode.fromJson(e)).toList();
    print(watchedEpisodes);
    return watchedEpisodes;
  }

  Future<void> changeWatchedEpisode(WatchedEpisode watchedEpisode) async {
    final watchedEpisodes =
        await getWatchedEpisodes(watchedEpisode.animeTitleId);
    if (watchedEpisodes.contains(watchedEpisode)) {
      await _updateWatchedEpisode(watchedEpisode);
    } else {
      await _addWatchedEpisode(watchedEpisode);
    }
    controller.add((await getWatchedEpisodes(watchedEpisode.animeTitleId)));
  }

  Future<void> deleteWatchedEpisode(WatchedEpisode watchedEpisode) async {
    final db = await getDB();
    db.delete(
      WatchedEpisode.tableName,
      where:
          '${WatchedEpisode.fieldAnimeTitleId} = ${watchedEpisode.animeTitleId}',
    );
    controller.add((await getWatchedEpisodes(watchedEpisode.animeTitleId)));
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
    db.update(WatchedEpisode.tableName, watchedEpisode.toJson());
  }

  WatchedEpisodesDAO() {
    controller = StreamController<List<WatchedEpisode>>.broadcast();
  }

  late final StreamController<List<WatchedEpisode>> controller;

  Stream<List<WatchedEpisode>> getEpisodesAsStream(int id) => controller.stream;

  Future<void> closeWatchedEpisodes() async {
    await controller.close();
  }
}
