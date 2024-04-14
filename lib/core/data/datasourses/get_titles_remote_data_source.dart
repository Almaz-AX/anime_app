// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/core/data/network/dio_client.dart';

abstract class GetTitlesRemoteDataSource {
  Future<List<AnimeTitle>> getTitles(List<int> titleIdList);
}

class GetTitlesRemoteDataSourceIml implements GetTitlesRemoteDataSource {
  final DioClient client;
  GetTitlesRemoteDataSourceIml({
    required this.client,
  });
  @override
  Future<List<AnimeTitle>> getTitles(List<int> titleIdList) async {
    final path =
        'title/list?id_list=${titleIdList.join(',')}&filter=id,names,posters,genres,type,status,player';
    final responseData = await client.get(path);
    final titleList = (responseData as List<dynamic>)
        .map((title) => AnimeTitle.fromJson(title))
        .toList();
    return titleList;
  }
}
