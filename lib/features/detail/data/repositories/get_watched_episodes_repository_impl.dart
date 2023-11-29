
import '../../../../core/data/local/entity/watched_episode.dart';

import '../../domain/repositories/get_watched_episodes_repository.dart';
import '../datasources/get_watched_episodes_local_data_source.dart';

class GetWatchedEpisodesRepositoryImpl implements GetWatchedEpisodesRepository {
  final GetWatchedEpisodesLocalDataSource localDataSource;

  GetWatchedEpisodesRepositoryImpl({required this.localDataSource});
  
  @override
  Stream<List<WatchedEpisode>> getWatchedEpisodes(int titleId) {
    return localDataSource.getWatchedEpisodes(titleId);
  }
  
  
}
