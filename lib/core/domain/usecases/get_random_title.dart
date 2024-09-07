
import 'package:anime_app/core/helpers/getResponseOrFailure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/core/data/models/release.dart';

import '../../data/repositories/anime_releases_repository.dart';
import '../../error/failure.dart';
import 'usecase.dart';

class GetRandomReleases implements UseCaseFuture<List<Release>, RandomParams> {
  final AnimeReleasesRepository repository;
  GetRandomReleases({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Release>>> call(RandomParams params) async {
    final releasesOrFailure = await getResponseOrFailure(
        () async => await repository.getRandomReleases(params.limit));
    return releasesOrFailure;
  }
}

class RandomParams extends Equatable {
  final int? limit;
  const RandomParams({
    this.limit,
  });

  @override
  List<Object?> get props => [limit];
}
