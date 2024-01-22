import 'dart:async';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/search/data/models/search_titles.dart';
import 'package:anime_app/features/home/data/models/title_updates.dart';
import 'package:dio/dio.dart';

import '../../../../core/host.dart';

class RestAPIService {
  // static const apiHost = Host.apiHost;
  final dio = Dio(
    BaseOptions(baseUrl: Host.apiHost),
  );
  // список значений, которые будут в ответе
  static const filter = 'id,names,posters,genres';

  Future<AnimeTitle> getTitle(int id) async {
    final path = 'title?id=$id';
    final response = await dio.get(path);
    final title = AnimeTitle.fromJson(response.data);
    print(title.id);
    return title;
  }

  Future<TitleUpdates> getUpdatedTitles(int? titlesCount) async {
    var path = 'title/updates';
    if (titlesCount != null) {
      path = 'title/updates?limit=10';
    }
    final response = await dio.get(path);
    final titleUpdates = TitleUpdates.fromJson(response.data);
    return titleUpdates;
  }

  Future<AnimeTitle> getRandomTitle() async {
    const path = '/title/random';
    final response = await dio.get(path);
    final title = AnimeTitle.fromJson(response.data);
    return title;
  }

  Future<SearchTitles> searchTitles(String query) async {
    final path = 'title/search?search=$query&filter=$filter';
    final response = await dio.get(path);
    final titleSearch = SearchTitles.fromJson(response.data);
    return titleSearch;
  }
}
