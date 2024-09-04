// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/helpers/getResponseOrFailure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/search_titles.repository.dart';
import '../datasources/search_remote_data_source.dart';

class SearchTitlesRepositoryImpl implements SearhTitlesRepository {
  final SearchTitlesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  SearchTitlesRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Release>>> getSearchedTitles(String query) async {
    return getResponseOrFailure(
      () async => await remoteDataSource.searchReleases(query),
    );
  }
}
