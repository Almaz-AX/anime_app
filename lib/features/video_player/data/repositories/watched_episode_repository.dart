import 'package:dartz/dartz.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/error/failure.dart';

abstract class WatchedEpisodeRepository {
  Future<Either<Failure, void>> saveEpisode(WatchedEpisode episode);

  Future<Either<Failure, List<WatchedEpisode>>> getEpisodes(int titleId);
}
