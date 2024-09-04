// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/helpers/getResponseOrFailure.dart';
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/detail/data/datasources/get_release_remote_data_source.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/get_title_repository.dart';

class GetTitleRepositoryImpl implements GetTitleRepository {
  final GetReleaseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  GetTitleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Release>> getTitle(int id) async {
    return getResponseOrFailure(
        () async => await remoteDataSource.getRelease(id));
  }
}
