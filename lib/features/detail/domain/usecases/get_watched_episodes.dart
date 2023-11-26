import 'package:dartz/dartz.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/get_watched_episodes_repository.dart';
import 'get_title.dart';

class GetWatchedEpisodes extends UseCase<Stream<List<WatchedEpisode>>, Params> {
  final GetWatchedEpisodesRepository repository;

  GetWatchedEpisodes({required this.repository});
  @override
  Future<Either<Failure, Stream<List<WatchedEpisode>>>> call(Params params) async {
    return await repository.getWatchedEpisodes(params.id);
  }
}
