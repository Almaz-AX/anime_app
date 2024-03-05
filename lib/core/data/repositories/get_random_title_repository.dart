// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/helpers/getResponseOrFailure.dart';
import 'package:dartz/dartz.dart';
import '../../error/failure.dart';
import '../../platform/network_info.dart';
import '../datasourses/get_random_title_remote_data_source.dart';
import '../models/anime_title.dart';

abstract class GetRandomTitleRepository {
  Future<Either<Failure, AnimeTitle>> getRandomTitle();
}

class GetRandomTitleRepositoryImpl implements GetRandomTitleRepository {
  final NetworkInfo networkInfo;
  final GetRandomTitleRemoteDataSource remoteDataSource;
  GetRandomTitleRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, AnimeTitle>> getRandomTitle() async {
    return getResponseOrFailure(
        () async => await remoteDataSource.getRandomTitle(),
        (await networkInfo.isConnected));
  }
}
