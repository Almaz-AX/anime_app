// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/data/local/entity/watched_episode.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/video_player/data/datasources/watched_episode_local_data_source.dart';
import 'package:anime_app/features/video_player/data/repositories/watched_episode_repository.dart';

class WatchedEpisodeRepositoryImpl extends WatchedEpisodeRepository {
  WatchedEpisodeLocalDataSource localDataSource;
  WatchedEpisodeRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, void>> saveEpisode(WatchedEpisode episode) async {
    try {
      return Right(await localDataSource.saveEpisode(episode));
    }
    //заглушка, возможно надо будет добавить возбуждение ошибки в datasource если надо будет
    on CasheFailure {
      return Left(CasheFailure());
    }
  }

  @override
  Future<Either<Failure, List<WatchedEpisode>>> getEpisodes(int titleId) async {
    try {
      return Right(await localDataSource.getEpisodes(titleId));
    }
    //заглушка, возможно надо будет добавить возбуждение ошибки в datasource если надо будет
    on CasheFailure {
      return Left(CasheFailure());
    }
  }
}
