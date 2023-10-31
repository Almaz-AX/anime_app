import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../entity/anime_title_db.dart';
import '../../entity/watched_episode.dart';

abstract class BaseDao {
  static const databaseVersion = 1;
  static const _databaseName = 'com.example.anime_app.db';

  Database? _database;

  @protected
  Future<Database> getDB() async {
    _database = await _getDatabase();
    return Future.value(_database);
  }

  Future<Database> _getDatabase() async {
    var databasesPath = await getDatabasesPath();
    final path = '$databasesPath/$_databaseName';
    return openDatabase(path, version: databaseVersion,
        onCreate: (db, version) async {
      final batch = db.batch();
      _createAnimeTitlesTableV1(batch);
      await batch.commit();
    });
  }

  void _createAnimeTitlesTableV1(Batch batch) {

    batch.execute('''
      CREATE TABLE IF NOT EXIST ${AnimeTitleDb.tableName}(
        ${AnimeTitleDb.fieldId} INTEGER PRIMIRY KEY,
        ${AnimeTitleDb.fieldTitleName} TEXT NOT NULL,
      )
      ''');

    batch.execute('''
    CREATE TABLE IF NOT EXIST ${WatchedEpisode.tableName}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${WatchedEpisode.fieldEpisodeNumber} INTEGER,
      ${WatchedEpisode.fieldWatchCompleted} BOOL NOT NULL,
      ${WatchedEpisode.fieldContinueTimestamp} INTEGER DEFAULT 0,
      ${WatchedEpisode.fieldAnimeTitleId} INTEGER NOT NULL,
      FOREIGN KEY ${WatchedEpisode.fieldAnimeTitleId} 
      REFERENCES ${AnimeTitleDb.tableName} (${AnimeTitleDb.fieldId}) 
      ON DELETE CASCADE,

    )
    ''');

  }
}
