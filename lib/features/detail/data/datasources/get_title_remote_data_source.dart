import 'package:anime_app/core/data/network/dio_client.dart';

import '../../../../core/data/models/anime_title.dart';

abstract class GetTitleRemoteDataSource {
  Future<AnimeTitle> getTitle(int id);
}

class GetTitleRemoteDataSourceImpl implements GetTitleRemoteDataSource {
  final DioClient client;
  GetTitleRemoteDataSourceImpl({required this.client});

  @override
  Future<AnimeTitle> getTitle(int id) async {
    final path = 'title?id=$id';
    final responseData = await client.get(path);
    final searchTitles = AnimeTitle.fromJson(responseData);
    return searchTitles;
  }
}
