import 'package:anime_app/core/data/models/release.dart';

import '../../../../core/data/network/dio_client.dart';

abstract class GetUpdatesRemoteDataSource {
  Future<List<Release>> latestReleases(int? limit);
}

class GetUpdatesRemoteDataSourceImpl implements GetUpdatesRemoteDataSource {
  final DioClient client;
  final since =
      DateTime.now().subtract(const Duration(days: 7)).millisecondsSinceEpoch ~/
          1000;

  GetUpdatesRemoteDataSourceImpl({required this.client});

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
