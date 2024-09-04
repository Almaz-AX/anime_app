import 'dart:async';

import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/error/exceptions.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/home/data/models/title_updates.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/helpers/getResponseOrFailure.dart';
import '../../../../core/platform/network_info.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/datasources/underseen_episodes_local_data_source.dart';

abstract class HomeRepository {
  Stream<List<WatchedEpisode>> listenUnderseenEpisodes();

  Future<Either<Failure, void>> completeWatching(WatchedEpisode episode);

  Future<Either<Failure, List<Release>>> latestReleases(int? page);
}

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final GetUpdatesRemoteDataSource remoteDataSource;
  final UnderseenEpisodesLocalDataSource localDatasource;
  late final Stream<List<WatchedEpisode>> _watchedEpisodesStream;
  HomeRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDatasource}) {
    _watchedEpisodesStream = localDatasource.listenUnderseenEpisodesHistory();
  }

  @override
  Future<Either<Failure, List<Release>>> latestReleases(int? page) async {
    return await getResponseOrFailure(
        () async => await remoteDataSource.latestReleases(page));
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
