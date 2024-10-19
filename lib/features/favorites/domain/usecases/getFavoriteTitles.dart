// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/repositories/anilibria_releases_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/domain/usecases/usecase.dart';
import 'package:anime_app/core/error/failure.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/helpers/getResponseOrFailure.dart';

class GetFavoriteTitles extends UseCaseFuture<List<Release>, Params> {
  final AnilibriaReleasesRepository repository;
  GetFavoriteTitles({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Release>>> call(Params params) async {
    return getResponseOrFailure<List<Release>>(() async {
      final favoriteReleases = <Release>[];
      for (int id in params.releasesId) {
        favoriteReleases.add(await repository.getRelease(id));
      }
      return favoriteReleases;
    });
  }
}

class Params {
  final List<int> releasesId;
  Params({
    required this.releasesId,
  });
}
