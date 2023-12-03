// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/data/local/entity/watched_episode.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/video_player/data/datasources/save_episode_local_data_source.dart';
import 'package:anime_app/features/video_player/data/repositories/save_watched_episode_repository.dart';

class SaveWatchedEpisodeRepositoryImpl extends SaveWatchedEpisodeRepository {
  SaveEpisodeLocalDataSource localDataSource;
  SaveWatchedEpisodeRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, void>> saveEpisode(WatchedEpisode episode) async {
    // TODO: implement saveEpisode
    try {
      return Right(await localDataSource.saveEpisode(episode));
    }
    //заглушка, возможно надо будет добавить возбуждение ошибки в datasource если надо будет
    on CasheFailure {
      return Left(CasheFailure());
    }
  }
}
