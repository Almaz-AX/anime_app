// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/domain/usecases/usecase.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/video_player/data/repositories/watched_episode_repository.dart';

import '../../../../core/data/local/entity/watched_episode.dart';

class SaveWatchedEpisode extends UseCaseFuture<void, Params> {
  final WatchedEpisodeRepository repository;
  SaveWatchedEpisode({
    required this.repository,
  });
  @override
  Future<Either<Failure, void>> call(Params params) {
    // TODO: implement call
    return repository.saveEpisode(params.watchedEpisode);
  }
}

class Params {
  final WatchedEpisode watchedEpisode;
  Params(this.watchedEpisode);
}
