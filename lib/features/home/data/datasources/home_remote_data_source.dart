import '../../../../core/data/network/dio_client.dart';
import '../models/title_updates.dart';

abstract class GetUpdatesRemoteDataSource {
  Future<TitleUpdates> getUpdates(int page);
}

class GetUpdatesRemoteDataSourceImpl implements GetUpdatesRemoteDataSource {
  final DioClient client;
  final since =
      DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch ~/
          1000;

  GetUpdatesRemoteDataSourceImpl({required this.client});

  @override
  Future<TitleUpdates> getUpdates(int page) async {
    final path =
        'title/updates?filter=id,names,genres,posters&since=$since&page=$page';
    final responseData = await client.get(path);
    final titleUpdates = TitleUpdates.fromJson(responseData);
    return titleUpdates;
  }
}
