import 'package:anime_app/core/data/network/dio_client.dart';
import '../../../../core/data/models/release.dart';

abstract class GetReleaseRemoteDataSource {
  Future<Release> getRelease(int id);
}

class GetReleaseRemoteDataSourceImpl implements GetReleaseRemoteDataSource {
  final Client client;
  GetReleaseRemoteDataSourceImpl({required this.client});

  @override
  Future<Release> getRelease(int id) async {
    final path = '/anime/releases/$id';
    final responseData = await client.get(path);
    return Release.fromJson(responseData);
  }
}
