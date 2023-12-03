import 'package:anime_app/core/data/repositories/anime_title_repository.dart';
import 'package:anime_app/core/host.dart';
import 'package:anime_app/features/detail/data/datasources/get_watched_episodes_local_data_source.dart';
import 'package:anime_app/features/detail/data/repositories/get_watched_episodes_repository_impl.dart';
import 'package:anime_app/features/detail/domain/usecases/get_watched_episodes.dart';
import 'package:anime_app/features/search/data/datasources/search_remote_data_source.dart';
import 'package:anime_app/features/search/data/repositories/search_titles_repository_impl.dart';
import 'package:anime_app/features/search/domain/usecases/get_searched_titles.dart';

import 'package:anime_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:anime_app/features/video_player/data/datasources/save_episode_local_data_source.dart';
import 'package:anime_app/features/video_player/data/repositories/save_watched_episode_repository.dart';
import 'package:anime_app/features/video_player/domain/repositories/save_watched_episode_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/data/datasourses/anime_title_remote_data_source.dart';
import 'core/data/local/DAO/watched_episode_dao.dart';
import 'core/domain/usecases/get_random_title.dart';
import 'core/platform/network_info.dart';
import 'features/detail/data/datasources/get_title_remote_data_source.dart';
import 'features/detail/data/repositories/get_title_repository_impl.dart';
import 'features/detail/domain/repositories/get_title_repository.dart';
import 'features/detail/domain/repositories/get_watched_episodes_repository.dart';
import 'features/detail/domain/usecases/get_title.dart';
import 'features/detail/presentation/blocs/detail_bloc.dart';
import 'features/search/domain/repositories/search_titles.repository.dart';
import 'features/video_player/domain/usecases/save_watched_episode.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features

  // SEARCH
  // Bloc
  sl.registerFactory(
      () => SearchBloc(getSearchedTitles: sl(), getRandomTitle: sl()));

  // Use cases
  sl.registerLazySingleton<GetSearchedTitles>(
      () => GetSearchedTitles(repository: sl()));

  // Repository
  sl.registerLazySingleton<SearhTitlesRepository>(() =>
      SearchTitlesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // DataSource
  sl.registerLazySingleton<SearchTitlesRemoteDataSource>(
      () => SearchTitlesRemoteDataSourceImpl(dio: sl()));

  // DETAIL
  // Bloc
  sl.registerFactory(
      () => DetailBloc(getTitle: sl(), getWatchedEpisodes: sl()));

  // Use cases
  sl.registerLazySingleton<GetTitle>(() => GetTitle(repository: sl()));
  sl.registerLazySingleton<GetWatchedEpisodes>(
      () => GetWatchedEpisodes(repository: sl()));

  // Repository
  sl.registerLazySingleton<GetTitleRepository>(
      () => GetTitleRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<GetWatchedEpisodesRepository>(
      () => GetWatchedEpisodesRepositoryImpl(localDataSource: sl()));

  // DataSource
  sl.registerLazySingleton<GetTitleRemoteDataSource>(
      () => GetTitleRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<GetWatchedEpisodesLocalDataSource>(
      () => GetWatchedEpisodesLocalDataSourceImpl(watchedEpisodesDAO: sl()));

  //VIDEOPLAYER
  //Usecase
  sl.registerLazySingleton<SaveWatchedEpisode>(
      () => SaveWatchedEpisode(repository: sl()));
  //Repository
  sl.registerLazySingleton<SaveWatchedEpisodeRepository>(
      () => SaveWatchedEpisodeRepositoryImpl(localDataSource: sl()));
  //LocalDataSource
  sl.registerLazySingleton<SaveEpisodeLocalDataSource>(
      () => SaveEpisodeLocalDataSourceImpl(watchedEpisodesDAO: sl()));

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Use case
  sl.registerLazySingleton<GetRandomTitle>(
      () => GetRandomTitle(repository: sl()));

  // Repository
  sl.registerLazySingleton<AnimeTitleRepository>(() =>
      AnimeTitleRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // DataSource
  sl.registerLazySingleton<AnimeTitleRemoteDataSource>(
      () => AnimeTitleRemoteDataSourceImpl(dio: sl()));

  // local
  //DAO
  sl.registerLazySingleton<WatchedEpisodesDAO>(() => WatchedEpisodesDAO());

  //! External
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(baseUrl: Host.apiHost),
      ));
}
