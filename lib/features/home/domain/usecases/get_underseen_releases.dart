// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/core/helpers/getResponseOrFailure.dart';
import 'package:anime_app/features/detail/data/datasources/get_release_remote_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/domain/usecases/usecase.dart';

class GetUnderseenReleases extends UseCaseFuture<List<Release>, Params> {
  final GetReleaseRemoteDataSource repository;
  GetUnderseenReleases({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Release>>> call(params) async {
    return getResponseOrFailure<List<Release>>(() async {
      final underseenReleases = <Release>[];
      for (int id in params.releasesId) {
        underseenReleases.add(await repository.getRelease(id));
      }
      return underseenReleases;
    });
  }
}

class Params extends Equatable {
  final List<int> releasesId;
  const Params({
    required this.releasesId,
  });

  @override
  List<Object?> get props => [releasesId];
}
