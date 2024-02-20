import 'package:anime_app/core/data/network/dio_client.dart';
import 'package:anime_app/features/search/data/models/search_titles.dart';

abstract class SearchTitlesRemoteDataSource {
  Future<SearchTitles> searchTitles(String query, int page);
}

class SearchTitlesRemoteDataSourceImpl implements SearchTitlesRemoteDataSource {
  final DioClient client;
  // список значений, которые будут в ответе
  static const filter = 'id,names,posters,genres';
  SearchTitlesRemoteDataSourceImpl({required this.client});

  @override
  Future<SearchTitles> searchTitles(String query, int page) async {
    String pagefilter = '';
    if (page > 1) {
      pagefilter = 'page=$page';
    }
    final path = 'title/search?search=$query&filter=$filter&$pagefilter';
    final responseData = await client.get(path);
    final searchTitles = SearchTitles.fromJson(responseData);
    return searchTitles;
  }
}
