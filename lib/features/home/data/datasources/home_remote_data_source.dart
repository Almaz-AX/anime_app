import '../../../../core/data/network/dio_client.dart';
import '../../../../core/data/models/anime_title.dart';
import '../models/title_updates.dart';

abstract class HomeReomoteDataSource {
  Future<List<AnimeTitle>> getTitles(List<int> titleIdList);
  Future<TitleUpdates> getUpdates(int page);
}

class HomeRemoteDataSourceImpl implements HomeReomoteDataSource {
  final DioClient client;
  final since =
      DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch ~/
          1000;

  HomeRemoteDataSourceImpl({required this.client});

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

  @override
  Future<TitleUpdates> getUpdates(int page) async {
    final path =
        'title/updates?filter=id,names,genres,posters&since=$since&page=$page';
    final responseData = await client.get(path);
    final titleUpdates = TitleUpdates.fromJson(responseData);
    return titleUpdates;
  }
}
