// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:isar/isar.dart';

import 'package:anime_app/features/search/data/models/search_titles.dart';

import '../../../../core/data/models/anime_title.dart';

abstract class SearchTitlesLocalDataSource {
  Future<SearchTitles> getLastSearchedTitles();
  Future<void> cacheLastSearchedtitles(SearchTitles searchResultToCache);
  Future<AnimeTitle> getLastRandomTitle();
  Future<void> cacheLastRandomTitle(AnimeTitle searchResultToCache);
}

class SearchTitlesLocalDataSourceImpl implements SearchTitlesLocalDataSource {
  final CacheManager cacheManager = DefaultCacheManager();
  final Isar isar;
  SearchTitlesLocalDataSourceImpl({
    required this.isar,
  });
  @override
  Future<void> cacheLastRandomTitle(AnimeTitle searchResultToCache) async{
    await cacheManager.downloadFile(searchResultToCache.posters.small.url, key: searchResultToCache.id.toString());
  }

  @override
  Future<void> cacheLastSearchedtitles(SearchTitles searchResultToCache) {
    // TODO: implement cacheLastSearchedtitles
    throw UnimplementedError();
  }

  @override
  Future<AnimeTitle> getLastRandomTitle() {
    throw UnimplementedError();
  }

  @override
  Future<SearchTitles> getLastSearchedTitles() {
    // TODO: implement getLastSearchedTitles
    throw UnimplementedError();
  }
}
