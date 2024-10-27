import 'package:anime_app/core/data/repositories/shikimori_repository.dart';
import 'package:anime_app/core/domain/usecases/get_shikimori_score.dart';
import 'package:anime_app/features/profile/domain/repositories/auth_repository.dart';
import 'package:anime_app/core/data/local/DAO/favorite_title_dao.dart';
import 'package:anime_app/core/data/network/dio_client.dart';
import 'package:anime_app/core/data/network/interceptors/dio_connectivity_request_retrier.dart';
import 'package:anime_app/core/data/network/interceptors/retry_on_connectivity_change_interceptor.dart';
import 'package:anime_app/features/favorites/domain/repositories/favorite_release_repository.dart';
import 'package:anime_app/core/data/repositories/anilibria_releases_repository.dart';
import 'package:anime_app/core/host.dart';
import 'package:anime_app/features/detail/data/datasources/get_watched_episodes_local_data_source.dart';
import 'package:anime_app/features/detail/data/repositories/get_watched_episodes_repository_impl.dart';
import 'package:anime_app/features/detail/domain/usecases/add_favorite_title.dart';
import 'package:anime_app/features/detail/domain/usecases/get_favorite_title.dart';
import 'package:anime_app/features/detail/domain/usecases/get_stream_watched_episodes.dart';
import 'package:anime_app/features/detail/domain/usecases/remove_favorite_title.dart';
import 'package:anime_app/features/favorites/domain/usecases/getFavoriteTitles.dart';
import 'package:anime_app/features/favorites/domain/usecases/listenFavoriteTitles.dart';
import 'package:anime_app/features/favorites/presentation/bloc/favorites_bloc.dart';

import 'package:anime_app/features/home/domain/repositories/home_repository.dart';
import 'package:anime_app/features/home/domain/usecases/complete_watching.dart';
import 'package:anime_app/features/home/domain/usecases/latest_releases.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_episodes.dart';
import 'package:anime_app/features/home/domain/usecases/get_underseen_releases.dart';
import 'package:anime_app/features/home/presentation/bloc/latest_releases_bloc/latest_releases_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/random_releases_bloc/bloc/random_releases_bloc.dart';
import 'package:anime_app/features/home/presentation/bloc/underseen_episodes_bloc/underseen_episodes_bloc.dart';
import 'package:anime_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:anime_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:anime_app/features/search/data/datasources/search_remote_data_source.dart';
import 'package:anime_app/features/search/data/repositories/search_titles_repository_impl.dart';
import 'package:anime_app/features/search/domain/usecases/get_searched_titles.dart';

import 'package:anime_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:anime_app/features/video_player/data/datasources/watched_episode_local_data_source.dart';
import 'package:anime_app/features/video_player/data/repositories/watched_episode_repository.dart';
import 'package:anime_app/features/video_player/domain/repositories/watched_episode_repository_impl.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/data/local/DAO/watched_episode_dao.dart';
import 'core/domain/usecases/get_random_title.dart';
import 'core/platform/network_info.dart';
import 'features/detail/domain/repositories/get_watched_episodes_repository.dart';
import 'features/detail/domain/usecases/get_title.dart';
import 'features/detail/presentation/blocs/detail_bloc.dart';
import 'features/home/data/datasources/underseen_episodes_local_data_source.dart';
import 'features/profile/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'features/profile/presentation/blocs/change_user_name_bloc/change_user_name_bloc.dart';
import 'features/search/domain/repositories/search_titles.repository.dart';
import 'features/video_player/domain/usecases/get_watched_episodes.dart';
import 'features/video_player/domain/usecases/save_watched_episode.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: '.env');
  final supabase = await Supabase.initialize(
      url: Host.supabaseUrl, anonKey: dotenv.get('SUPABASE_KEY'));
//! Features
  //HOME
  //Bloc
  sl.registerFactory(() => UnderseenEpisodesBloc(
      getUnderseenEpisodes: sl(),
      getUnderseenTitles: sl(),
      completeWatching: sl()));

  sl.registerFactory(() => LatestReleasesBloc(
        getLatestReleases: sl(),
        getShikimoriScore: sl()
      ));

  sl.registerFactory(() => RandomReleasesBloc(getRandomTitle: sl(), getShikimoriScore: sl()));
  //Use cases
  sl.registerLazySingleton<GetUnderseenEpisodes>(
      () => GetUnderseenEpisodes(repository: sl()));
  sl.registerLazySingleton<GetUnderseenReleases>(
      () => GetUnderseenReleases(repository: sl()));
  sl.registerLazySingleton<CompleteWatching>(
      () => CompleteWatching(repository: sl()));
  sl.registerLazySingleton<LatestReleases>(
      () => LatestReleases(repository: sl()));
  //Repsitory
  sl.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(localDatasource: sl()));
  //DataSource
  sl.registerLazySingleton<UnderseenEpisodesLocalDataSource>(
      () => UnderseenEpisodesLocalDataSourceImpl(local: sl()));

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
      () => SearchTitlesRemoteDataSourceImpl(client: sl()));

  // DETAIL
  // Bloc
  sl.registerFactory(() => DetailBloc(
      getTitle: sl(),
      getWatchedEpisodes: sl(),
      getFavoriteTitle: sl(),
      addFavoriteTitle: sl(),
      getScore: sl(),
      removeFavoriteTitle: sl()));

  // Use cases
  sl.registerLazySingleton<GetTitle>(() => GetTitle(repository: sl()));
  sl.registerLazySingleton<GetStreamWatchedEpisodes>(
      () => GetStreamWatchedEpisodes(repository: sl()));
  sl.registerLazySingleton<GetFavoriteTitle>(
      () => GetFavoriteTitle(repository: sl()));
  sl.registerLazySingleton<AddFavoriteTitle>(
      () => AddFavoriteTitle(repository: sl()));
  sl.registerLazySingleton(() => RemoveFavoriteTitle(repository: sl()));

  // Repository
  sl.registerLazySingleton<GetWatchedEpisodesRepository>(
      () => GetWatchedEpisodesRepositoryImpl(localDataSource: sl()));

  // DataSource
  sl.registerLazySingleton<GetWatchedEpisodesLocalDataSource>(
      () => GetWatchedEpisodesLocalDataSourceImpl(watchedEpisodesDAO: sl()));

  //FAVORITES
  sl.registerFactory(
      () => FavoritesBloc(listenFavoriteTitles: sl(), getFavoriteTitles: sl()));
  //Usecase
  sl.registerLazySingleton(() => ListenFavoriteTitles(repository: sl()));
  sl.registerLazySingleton(() => GetFavoriteTitles(repository: sl()));

  //PROFILE
  //Bloc
  sl.registerFactory(() => ProfileBloc(repository: sl<ProfileRepository>()));
  sl.registerFactory(() => AuthBloc(repository: sl()));
  sl.registerFactory(() => ChangeUserNameBloc(repository: sl()));
  //Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        supabase: sl(),
      ));
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositiryImpl(supabase: sl()));

  //VIDEOPLAYER
  //Usecase
  sl.registerLazySingleton<SaveWatchedEpisode>(
      () => SaveWatchedEpisode(repository: sl()));
  sl.registerLazySingleton<GetWatchedEpisodes>(
      () => GetWatchedEpisodes(repository: sl()));
  //Repository
  sl.registerLazySingleton<WatchedEpisodeRepository>(
      () => WatchedEpisodeRepositoryImpl(localDataSource: sl()));
  //LocalDataSource
  sl.registerLazySingleton<WatchedEpisodeLocalDataSource>(
      () => WatchedEpisodeLocalDataSourceImpl(watchedEpisodesDAO: sl()));

//! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<Client>(
      () => DioClient(dio: sl(), connectivityChangeInterceptor: sl()));

  // Usecase
  sl.registerLazySingleton<GetRandomReleases>(
      () => GetRandomReleases(repository: sl()));

  sl.registerLazySingleton<GetShikimoriScore>(
      () => GetShikimoriScore(repository: sl()));

  // Repository
  sl.registerLazySingleton<AnilibriaReleasesRepository>(
      () => AnilibriaReleasesRepositoryImpl(client: sl()));

  sl.registerLazySingleton<ShikimoriAnimeRepository>(
      () => ShikimoriAnimeRepositoryImpl(client: sl()));

  sl.registerLazySingleton<FavoriteReleaseRepository>(
      () => FavoriteReleaseRepositoryImpl(favioriteTitlesDAO: sl()));

  //client
  sl.registerLazySingleton(
      () => DioClient(dio: sl(), connectivityChangeInterceptor: sl()));
  sl.registerLazySingleton(
      () => RetryOnConnectivityChangeInterceptor(requestRetrier: sl()));
  sl.registerLazySingleton(
    () => DioConnectivityRequestRetrier(dio: sl(), networkInfo: sl()),
  );

  // local
  //DAO
  sl.registerLazySingleton<WatchedEpisodesDAO>(() => WatchedEpisodesDAO());
  sl.registerLazySingleton<FavoriteTitlesDAO>(() => FavoriteTitlesDAO());
  //! External
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<Supabase>(() => supabase);
  // sl.registerLazySingleton<FlutterSecureStorage>(
  //     () => const FlutterSecureStorage());
}
