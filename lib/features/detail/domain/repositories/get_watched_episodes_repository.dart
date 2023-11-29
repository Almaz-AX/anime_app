
import '../../../../core/data/local/entity/watched_episode.dart';


abstract class GetWatchedEpisodesRepository {
   Stream<List<WatchedEpisode>> getWatchedEpisodes(int titleId);
}
