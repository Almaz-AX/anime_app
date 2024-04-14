import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/core/platform/network_info.dart';
import 'package:dartz/dartz.dart';

import '../../error/failure.dart';
import '../../helpers/getResponseOrFailure.dart';
import '../datasourses/get_titles_remote_data_source.dart';

abstract class GetTitlesRepository {
  Future<Either<Failure, List<AnimeTitle>>> getTitles(List<int> titleIdList);
}

class GetTitlesRepositoryImpl implements GetTitlesRepository {
  final NetworkInfo networkInfo;
  final GetTitlesRemoteDataSource remoteDataSource;
  GetTitlesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<AnimeTitle>>> getTitles(
      List<int> titleIdList) async {
    return getResponseOrFailure(
        () async => await remoteDataSource.getTitles(titleIdList));
  }
}
