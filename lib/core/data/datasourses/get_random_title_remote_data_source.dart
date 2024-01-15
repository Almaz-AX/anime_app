// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import '../../error/expetions.dart';
import '../models/anime_title.dart';

abstract class GetRandomTitleRemoteDataSource {
  Future<AnimeTitle> getRandomTitle();
}

class GetRandomTitleRemoteDataSourceImpl
    implements GetRandomTitleRemoteDataSource {
  final Dio dio;
  GetRandomTitleRemoteDataSourceImpl({
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
