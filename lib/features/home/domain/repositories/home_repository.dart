import 'dart:async';

import 'package:anime_app/core/error/expetions.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/home/data/models/title_updates.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/data/local/entity/watched_episode.dart';
import '../../../../core/data/models/anime_title.dart';
import '../../../../core/helpers/getResponseOrFailure.dart';
import '../../../../core/platform/network_info.dart';
import '../../data/datasources/home_remote_data_source.dart';
import '../../data/datasources/underseen_episodes_local_data_source.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<AnimeTitle>>> getTitles(List<int> titleIdList);

  Stream<List<WatchedEpisode>> listenUnderseenEpisodes();

  Future<Either<Failure, void>> completeWatching(WatchedEpisode episode);

  Future<Either<Failure, TitleUpdates>> getUpdates(int page);
}

class HomeRepositoryImpl implements HomeRepository {
  final NetworkInfo networkInfo;
  final HomeReomoteDataSource remoteDataSource;
  final UnderseenEpisodesLocalDataSource localDatasource;
  late final Stream<List<WatchedEpisode>> _watchedEpisodesStream;
  HomeRepositoryImpl(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDatasource}) {
    _watchedEpisodesStream = localDatasource.listenUnderseenEpisodesHistory();
  }

  @override
  Future<Either<Failure, List<AnimeTitle>>> getTitles(
      List<int> titleIdList) async {
    return await getResponseOrFailure(
        () async => await remoteDataSource.getTitles(titleIdList),
        (await networkInfo.isConnected));
  }

  @override
  Future<Either<Failure, TitleUpdates>> getUpdates(int page) async {
    return await getResponseOrFailure(
        () async => await remoteDataSource.getUpdates(page),
        (await networkInfo.isConnected));
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
    on NetworkExeption {
      return Left(NetworkConnectionFailure());
    }
  }
}
