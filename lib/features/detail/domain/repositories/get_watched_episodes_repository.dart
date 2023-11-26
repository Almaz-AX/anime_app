import 'package:dartz/dartz.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/error/failure.dart';

abstract class GetWatchedEpisodesRepository {
  Future<Either<Failure, Stream<List<WatchedEpisode>>>> getWatchedEpisodes(int titleId);
}
