import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repositories/get_watched_episodes_repository.dart';
import '../datasources/get_watched_episodes_local_data_source.dart';

class GetWatchedEpisodesRepositoryImpl implements GetWatchedEpisodesRepository {
  final GetWatchedEpisodesLocalDataSource localDataSource;

  GetWatchedEpisodesRepositoryImpl({required this.localDataSource});
  @override
  Future<Either<Failure, Stream<List<WatchedEpisode>>>> getWatchedEpisodes(int titleId) async {
    try{
      final watchedEpisodes = await localDataSource.getWatchedEpisodes(titleId);
      return Right(watchedEpisodes);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
