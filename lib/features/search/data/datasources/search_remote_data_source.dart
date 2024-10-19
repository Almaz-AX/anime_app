import '../../../../core/data/network/dio_client.dart';
import '../../../../core/data/models/release.dart';

abstract class SearchTitlesRemoteDataSource {
  Future<List<Release>> searchReleases(String query);
}

class SearchTitlesRemoteDataSourceImpl implements SearchTitlesRemoteDataSource {
  final DioClient client;
  SearchTitlesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Release>> searchReleases(String query) async {
    final path = '/app/search/releases?query=$query';
    final responseData = await client.get(path) as List;
    final searchTitles =
        responseData.map((data) => Release.fromJson(data)).toList();
    return searchTitles;
  }
}
