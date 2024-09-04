// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/network/dio_client.dart';

import '../models/release.dart';



abstract class GetRandomReleaseRemoteDataSource {
  Future<List<Release>> getRandomRelease(int? limit);
}

class GetRandomReleaseRemoteDataSourceImpl
    implements GetRandomReleaseRemoteDataSource {
  final DioClient client;
  GetRandomReleaseRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<List<Release>> getRandomRelease(int? limit) async {
    String path = '/anime/releases/random';
    if (limit != null && limit > 0) {
      path = '$path?limit=$limit';
    }
    final List responseData = await client.get(path);
  
    return responseData.map((e) => Release.fromJson(e)).toList();
  }
}
