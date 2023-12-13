// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/error/failure.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../data/repositories/watched_episode_repository.dart';

class GetWatchedEpisodes extends UseCaseFuture<List<WatchedEpisode>, Params> {
  final WatchedEpisodeRepository repository;
  GetWatchedEpisodes({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<WatchedEpisode>>> call(Params params) {
    return repository.getEpisodes(params.titleId);
  }
}

class Params {
  final int titleId;
  Params(
    this.titleId,
  );
}
