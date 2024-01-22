import 'package:anime_app/core/error/expetions.dart';
import 'package:dio/dio.dart';

import '../../../../core/data/models/anime_title.dart';
import '../models/title_updates.dart';

abstract class HomeReomoteDataSource {
  Future<List<AnimeTitle>> getTitles(List<int> titleIdList);
  Future<TitleUpdates> getUpdates(int page);
}

class HomeRemoteDataSourceImpl implements HomeReomoteDataSource {
  final Dio dio;
  final since =
      DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch ~/
          1000;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<AnimeTitle>> getTitles(List<int> titleIdList) async {
    final path =
        '/title/list?id_list=${titleIdList.join(',')}&filter=id,names,posters,genres,type,status,player';
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      final titleList = (response.data as List<dynamic>)
          .map((title) => AnimeTitle.fromJson(title))
          .toList();
      return titleList;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<TitleUpdates> getUpdates(int page) async {
    final path =
        'title/updates?filter=id,names,genres,posters&since=$since&page=$page';
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      final titleUpdates = TitleUpdates.fromJson(response.data);
      return titleUpdates;
    } else {
      throw ServerExeption();
    }
  }
}
