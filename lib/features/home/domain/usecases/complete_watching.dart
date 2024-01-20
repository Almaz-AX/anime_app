// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/data/local/entity/watched_episode.dart';
import 'package:anime_app/core/domain/usecases/usecase.dart';
import 'package:anime_app/core/error/failure.dart';

import '../repositories/home_repository.dart';

class CompleteWatching extends UseCaseFuture {
  final HomeRepository repository;
  CompleteWatching({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(params) {
    return repository.completeWatching(params.episode);
  }
}

class EpisodeParams {
  WatchedEpisode episode;
  EpisodeParams({
    required this.episode,
  });
}
