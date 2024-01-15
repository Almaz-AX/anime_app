import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/data/models/anime_title.dart';
import '../../../../core/error/failure.dart';

abstract class HomeReomoteDataSource {
  Future<Either<Failure, List<AnimeTitle>>> getTitles(List<int> titleIdList);
}

class HomeRemoteDataSourceImpl implements HomeReomoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, List<AnimeTitle>>> getTitles(
      List<int> titleIdList) async {
    final path =
        '/title/list?id_list=${titleIdList.join(',')}&filter=id,names,posters,genres,type,status,player';
    final response = await dio.get(path);
    if (response.statusCode == 200) {
      final titleList = (response.data as List<dynamic>)
          .map((title) => AnimeTitle.fromJson(title))
          .toList();
      return Right(titleList);
    } else {
      return Left(ServerFailure());
    }
  }
}
