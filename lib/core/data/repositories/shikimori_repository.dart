// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/shikimori_anime.dart';

import '../network/dio_client.dart';

abstract interface class ShikimoriAnimeRepository {
  Future<ShikimoriAnime?> getScore(String releaseName);
}

class ShikimoriAnimeRepositoryImpl implements ShikimoriAnimeRepository {
  final Client client;
  ShikimoriAnimeRepositoryImpl({
    required this.client,
  });
  @override
  Future<ShikimoriAnime?> getScore(String releaseName) async {

    final Map<String, dynamic> response =
        await client.post("https://shikimori.one/api/graphql", data: {
      'query': 'query Animes {animes(search: "$releaseName", limit: 1) {id name score}}'
    });
    try {
      final data = response['data']['animes'] as List<dynamic>;
      return data.firstOrNull != null? ShikimoriAnime.fromJson(data.first): null;
    } catch (e) {
      rethrow;
    }
    
  }
}
