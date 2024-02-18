// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/detail/data/datasources/get_title_remote_data_source.dart';

import '../../../../core/error/expetions.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/get_title_repository.dart';

class GetTitleRepositoryImpl implements GetTitleRepository {
  final GetTitleRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  GetTitleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, AnimeTitle>> getTitle(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAnimeTitles = await remoteDataSource.getTitle(id);
        return Right(remoteAnimeTitles);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    }
    return Left(CasheFailure());
  }
}
