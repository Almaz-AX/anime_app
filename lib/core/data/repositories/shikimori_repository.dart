// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/shikimori_anime.dart';

import '../network/dio_client.dart';

abstract interface class ShikimoriAnimeRepository {
  Future<List<ShikimoriAnime>> getScore(
      {String? releaseName = "",
      String status = "",
      int limit = 1,
      String season = '',
      int page = 1
      });
}

class ShikimoriAnimeRepositoryImpl implements ShikimoriAnimeRepository {
  final Client client;
  ShikimoriAnimeRepositoryImpl({
    required this.client,
  });
  @override
  Future<List<ShikimoriAnime>> getScore(
      {String? releaseName = "",
      String status = "",
      String season = '',
      int limit = 1,
      int page = 1,}) async {
    final Map<String, dynamic> response =
        await client.post("https://shikimori.one/api/graphql", data: {
      'query':
          'query Animes {animes(search: "$releaseName", status: "$status", season: "$season", limit: $limit, page: $page, order: popularity) {id name score}}'
    });
    try {
      final data = response['data']['animes'] as List<dynamic>;
      return data.map((e) => ShikimoriAnime.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
