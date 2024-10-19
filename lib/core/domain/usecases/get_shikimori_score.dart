// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/shikimori_anime.dart';
import 'package:anime_app/core/data/repositories/shikimori_repository.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import 'usecase.dart';

class GetShikimoriScore
    implements UseCaseFuture<ShikimoriAnime?, ShikimoriParams> {
  final ShikimoriAnimeRepository repository;
  GetShikimoriScore({
    required this.repository,
  });

  @override
  Future<Either<Failure, ShikimoriAnime?>> call(
      ShikimoriParams params) async {
    try {

        return Right(await repository.getScore(params.releaseName));

    } catch (e) {
      Left(Error());
      rethrow;
    }
  }
}

class ShikimoriParams {
  final String releaseName;
  ShikimoriParams({
    required this.releaseName,
  });
}
