import 'dart:async';

import 'package:anime_app/core/error/exceptions.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../data/datasources/underseen_episodes_local_data_source.dart';

abstract class LocalRepository {
  Stream<List<WatchedEpisode>> listenUnderseenEpisodes();

  Future<Either<Failure, void>> completeWatching(WatchedEpisode episode);
}

class LocalRepositoryImpl implements LocalRepository {
  final UnderseenEpisodesLocalDataSource localDatasource;
  late final Stream<List<WatchedEpisode>> _watchedEpisodesStream;
  LocalRepositoryImpl(
      { required this.localDatasource}) {
    _watchedEpisodesStream = localDatasource.listenUnderseenEpisodesHistory();
  }

  @override
  Stream<List<WatchedEpisode>> listenUnderseenEpisodes() =>
      _watchedEpisodesStream;

  @override
  Future<Either<Failure, void>> completeWatching(episode) async {
    try {
      return Right(await localDatasource.completeWatching(episode));
    }
    //заглушка, возможно надо будет добавить возбуждение ошибки в datasource если надо будет
    on DatabaseExeption {
      return Left(DatabaseFailure());
    }
  }
}
