import 'package:dio/dio.dart';

import '../../../../core/data/models/anime_title.dart';
import '../../../../core/error/expetions.dart';

abstract class GetTitleRemoteDataSource {
  Future<AnimeTitle> getTitle(int id);
}

class GetTitleRemoteDataSourceImpl implements GetTitleRemoteDataSource {
  final Dio dio;
  GetTitleRemoteDataSourceImpl({required this.dio});
 

  @override
  Future<AnimeTitle> getTitle(int id) async {
    final path = 'title?id=$id';
    final response = await dio.get(path);

    if (response.statusCode == 200) {
      final searchTitles = AnimeTitle.fromJson(response.data);
      return searchTitles;
    } else {
      throw ServerExeption();
    }
  }
}
