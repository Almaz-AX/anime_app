import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/get_watched_episodes_repository.dart';
import 'get_title.dart';

class GetWatchedEpisodes
    extends UseCaseStream<List<WatchedEpisode>, Params> {
  final GetWatchedEpisodesRepository repository;

  GetWatchedEpisodes({required this.repository});
  
  @override
  Stream<List<WatchedEpisode>> call(Params params) {
    return repository.getWatchedEpisodes(params.id);
  }
}
  


