import 'package:dio/dio.dart';

import '../../../../core/data/models/anime_title.dart';
import '../../../../core/error/expetions.dart';

abstract class HomeReomoteDataSource {
  getEpisodes(List<int> titleIdList);
}

class HomeRemoteDataSourceImpl implements HomeReomoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<AnimeTitle>> getEpisodes(List<int> titleIdList) async {
    final path =
        '/title/list?id_list=${titleIdList.join(',')}&filter=names,posters,type,status,player';
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
}
