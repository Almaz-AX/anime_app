import 'dart:async';

import 'package:anime_app/domain/entity/isar_data/watched_title.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> _db;
  final StreamController controller = StreamController();
  IsarService() {
    _db = _openDB();
  }

  static Future<Isar> _openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      return Isar.open([WatchedTitleSchema], directory: directory.path);
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveTitleEpisode(int titleId, int episodeId) async {
    final isar = await _db;
    final title = (await getTitle(titleId));

    await isar.writeTxn(() async {
      if (title == null) {
        final title = WatchedTitle(id: titleId, watchedEpisodes: [episodeId]);
        await isar.watchedTitles.put(title);
        return;
      }

      if (title.watchedEpisodes.contains(episodeId)) {
        return;
      }
      print(title.watchedEpisodes);
      final newWatchedList = List.of(title.watchedEpisodes);
      newWatchedList.add(episodeId);
      title.watchedEpisodes = newWatchedList;
      print('Добавлен епизод ${title.watchedEpisodes}');
      title.watchedEpisodes.sort();
      await isar.watchedTitles.put(title);
    });
  }

  Future<WatchedTitle?> getTitle(int titleId) async {
    final isar = await _db;
    final title = isar.txnSync(() => isar.watchedTitles.getSync(titleId));
    return title;
  }

  Stream<WatchedTitle?> listenTitle(int titleId) async* {
    final isar = await _db;
    final title = isar.txnSync(() => isar.watchedTitles.watchObject(titleId, fireImmediately: true));
    yield* title;
  }

  Future<void> closeIsar() async {
    final isar = await _db;
    await isar.close();
  }
}
