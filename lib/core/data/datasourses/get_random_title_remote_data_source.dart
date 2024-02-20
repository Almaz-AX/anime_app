// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/network/dio_client.dart';

import '../models/anime_title.dart';

abstract class GetRandomTitleRemoteDataSource {
  Future<AnimeTitle> getRandomTitle();
}

class GetRandomTitleRemoteDataSourceImpl
    implements GetRandomTitleRemoteDataSource {
  final DioClient client;
  GetRandomTitleRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<AnimeTitle> getRandomTitle() async {
    const path = 'title/random';
    final responseData = await client.get(path);
    final title = AnimeTitle.fromJson(responseData);
    return title;
  }
}
