import 'dart:async';
import 'dart:io';

import 'package:anime_app/core/data/local/entity/favorite_title.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../entity/anime_title_db.dart';
import '../entity/watched_episode.dart';
import 'package:path_provider/path_provider.dart';

abstract class BaseDAO {
  static const databaseVersion = 1;
  static const _databaseName = 'com.example.anime_app.db';

  Database? _database;

  @protected
  Future<Database> getDB() async {
    _database = await _getDatabase();
    return Future.value(_database);
  }

  Future<Database> _getDatabase() async {
    final databasesPath = await getApplicationDocumentsDirectory();
    final path = '$databasesPath/$_databaseName';
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      return await databaseFactoryFfi.openDatabase(path,
          options: OpenDatabaseOptions(
            version: databaseVersion,
            onCreate: (db, version) async {
              final batch = db.batch();
              _createAnimeTitlesTableV1(batch);
              _createWatchedEpisodeTableV1(batch);
              _createFavoriteTitleTableV1(batch);
              await batch.commit();
            },
          ));
    }

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: (db, version) async {
        final batch = db.batch();
        _createAnimeTitlesTableV1(batch);
        _createWatchedEpisodeTableV1(batch);
        _createFavoriteTitleTableV1(batch);
        await batch.commit();
      },
    );
  }

  void _createAnimeTitlesTableV1(Batch batch) {
    batch.execute('''
      CREATE TABLE ${AnimeTitleDb.tableName}(
        ${AnimeTitleDb.fieldId} INTEGER PRIMARY KEY,
        ${AnimeTitleDb.fieldTitleName} TEXT NOT NULL
      )
      ''');
  }

  void _createWatchedEpisodeTableV1(Batch batch) {
    batch.execute('''
    CREATE TABLE ${WatchedEpisode.tableName}(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      ${WatchedEpisode.fieldEpisodeNumber} INTEGER,
      ${WatchedEpisode.fieldWatchCompleted} INTEGER NOT NULL,
      ${WatchedEpisode.fieldContinueTimestamp} INTEGER DEFAULT 0,
      ${WatchedEpisode.fieldReleaseId} INTEGER NOT NULL,
      ${WatchedEpisode.fieldUpdatedTime} INTEGER NOT NULL,
      FOREIGN KEY (${WatchedEpisode.fieldReleaseId}) REFERENCES ${AnimeTitleDb.tableName}(${AnimeTitleDb.fieldId}) ON DELETE CASCADE
    )
    ''');
  }

  void _createFavoriteTitleTableV1(Batch batch) {
    batch.execute('''
    CREATE TABLE ${FavoriteTitle.tableName}(
      ${FavoriteTitle.fieldAnimeTitleId} INTEGER NOT NULL,
      FOREIGN KEY (${FavoriteTitle.fieldAnimeTitleId}) REFERENCES ${AnimeTitleDb.tableName}(${AnimeTitleDb.fieldId}) ON DELETE CASCADE
    )
    ''');
  }

  Future<void> closeDb() async {
    await _database?.close();
  }
}
