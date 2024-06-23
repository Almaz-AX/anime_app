import 'dart:async';

import 'package:anime_app/core/data/local/DAO/base_dao.dart';
import 'package:anime_app/core/data/local/entity/favorite_title.dart';

class FavoriteTitlesDAO extends BaseDAO {
  final favoriteTitleController =
      StreamController<List<FavoriteTitle>>.broadcast();
  FavoriteTitlesDAO() {
    _getTitles().then((value) => favoriteTitleController.sink.add(value));
  }
  Stream<List<FavoriteTitle>> listenTitles() => favoriteTitleController.stream;

  Future<List<FavoriteTitle>> _getTitles() async {
    final db = await getDB();
    List<Map<String, dynamic>> maps;
    maps = await db.query(
      FavoriteTitle.tableName,
    );
    final favoriteTitles = maps.map((e) => FavoriteTitle.fromJson(e)).toList();
    return favoriteTitles;
  }

  Future<FavoriteTitle?> getTitle(int titleId) async {
    final db = await getDB();
    List<Map<String, dynamic>> maps;
    maps = await db.query(
      FavoriteTitle.tableName,
      where: '${FavoriteTitle.fieldAnimeTitleId} = $titleId',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => FavoriteTitle.fromJson(e)).first;
    }
    return null;
  }

  Future<int> addTitle(int titleId) async {
    final db = await getDB();
    final id = await db.insert(
        FavoriteTitle.tableName, FavoriteTitle(animeTitleId: titleId).toJson());
    favoriteTitleController.sink.add(await _getTitles());
    return id;
  }

  Future<int> removeTitle(int titleId) async {
    final db = await getDB();
    final id = await db.delete(FavoriteTitle.tableName,
        where: '${FavoriteTitle.fieldAnimeTitleId} = $titleId');
    favoriteTitleController.sink.add(await _getTitles());
    return id;
  }
}
