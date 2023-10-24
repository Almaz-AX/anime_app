import 'package:anime_app/core/error/expetions.dart';
import 'package:anime_app/features/search/data/models/search_titles.dart';
import 'package:dio/dio.dart';



abstract class SearchTitlesRemoteDataSource {
  Future<SearchTitles> searchTitles(String query, int page);
}

class SearchTitlesRemoteDataSourceImpl implements SearchTitlesRemoteDataSource {
  final Dio dio;
  // список значений, которые будут в ответе
  static const filter = 'id,names,posters,genres';
  SearchTitlesRemoteDataSourceImpl({required this.dio});
 

  @override
  Future<SearchTitles> searchTitles(String query, int page) async {
    String pagefilter = '';
    if (page > 1) {
      pagefilter = 'page=$page';
    }
    final path = 'title/search?search=$query&filter=$filter&$pagefilter';
    final response = await dio.get(path);

    if (response.statusCode == 200) {
      final searchTitles = SearchTitles.fromJson(response.data);
      return searchTitles;
    } else {
      throw ServerExeption();
    }
  }
}
