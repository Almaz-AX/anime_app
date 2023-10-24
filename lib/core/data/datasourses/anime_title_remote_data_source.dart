// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../../error/expetions.dart';
import '../models/anime_title.dart';

abstract class AnimeTitleRemoteDataSource {
  Future<AnimeTitle> getRandomTitle();
}

class AnimeTitleRemoteDataSourceImpl implements AnimeTitleRemoteDataSource {
  final Dio dio;
  AnimeTitleRemoteDataSourceImpl({
    required this.dio,
  });
  @override
  Future<AnimeTitle> getRandomTitle() async {
    const path = '/title/random';
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      final title = AnimeTitle.fromJson(response.data);
      return title;
    } else {
      throw ServerExeption();
    }
  }
  
}
