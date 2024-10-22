// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/models/shikimori_anime.dart';
import 'package:anime_app/core/data/repositories/shikimori_repository.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import 'usecase.dart';

class GetShikimoriScore
    implements UseCaseFuture<List<ShikimoriAnime>, ShikimoriParams> {
  final ShikimoriAnimeRepository repository;
  GetShikimoriScore({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<ShikimoriAnime>>> call(
      ShikimoriParams params) async {
    try {

      return Right(await repository.getScore(
          releaseName: params.releaseName,
          status: params.status,
          limit: params.limit,
          season: params.season,
          page: params.page
          ));
    } catch (e) {
      Left(Error());
      rethrow;
    }
  }
}

class ShikimoriParams {
  final String releaseName;
  final String status;
  final String season;
  final int limit;
  final int page;
  ShikimoriParams(
      {this.releaseName = '',
      this.status = '',
      this.season = '',
      this.limit = 1,
      this.page = 1});
}
