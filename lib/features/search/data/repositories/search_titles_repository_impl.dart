// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/error/expetions.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/search_titles.repository.dart';
import '../datasources/search_remote_data_source.dart';
import '../models/search_titles.dart';

class SearchTitlesRepositoryImpl implements SearhTitlesRepository {
  final SearchTitlesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  SearchTitlesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SearchTitles>> getSearchedTitles(
      String query, page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAnimeTitles =
            await remoteDataSource.searchTitles(query, page);
        return Right(remoteAnimeTitles);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    }
    return Left(CasheFailure());
  }
}
