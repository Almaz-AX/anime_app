import '../models/release.dart';
import '../network/dio_client.dart';

abstract class AnilibriaReleasesRepository {
  Future<List<Release>> getRandomReleases(int? limit);
  Future<Release> getRelease(int id);
  Future<List<Release>> latestReleases(int? limit);
}

class AnilibriaReleasesRepositoryImpl implements AnilibriaReleasesRepository {
  final Client client;
  AnilibriaReleasesRepositoryImpl({required this.client});

  @override
  Future<List<Release>> getRandomReleases(int? limit) async {
    String path = '/anime/releases/random';
    if (limit != null && limit > 0) {
      path = '$path?limit=$limit';
    }
    final List responseData = await client.get(path);

    return responseData.map((e) => Release.fromJson(e)).toList();
  }

  @override
  Future<Release> getRelease(int id) async {
    final path = '/anime/releases/$id';
    final responseData = await client.get(path);
    return Release.fromJson(responseData);
  }

  @override
  Future<List<Release>> latestReleases(int? limit) async {
    String path = '/anime/releases/latest';
    if (limit != null && limit > 0) {
      path = '$path?limit=$limit';
    }
    final List responseData = await client.get(path);

    return responseData.map((e) => Release.fromJson(e)).toList();
  }
}
