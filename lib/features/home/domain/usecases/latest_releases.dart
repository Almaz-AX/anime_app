import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/data/repositories/anilibria_releases_repository.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/helpers/getResponseOrFailure.dart';

class LatestReleases extends UseCaseFuture<List<Release>, Params> {
  final AnilibriaReleasesRepository repository;
  LatestReleases({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Release>>> call(params) async {
    return await getResponseOrFailure(
        () async => await repository.latestReleases(params.limit));
  }
}

class Params extends Equatable {
  final int? limit;
  const Params({
    this.limit,
  });

  @override
  List<Object?> get props => [limit];
}
