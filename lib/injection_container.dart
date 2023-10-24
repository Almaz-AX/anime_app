import 'package:anime_app/core/data/repositories/anime_title_repository.dart';
import 'package:anime_app/core/host.dart';
import 'package:anime_app/features/search/data/datasources/search_remote_data_source.dart';
import 'package:anime_app/features/search/data/repositories/search_titles_repository_impl.dart';
import 'package:anime_app/features/search/domain/usecases/get_searched_titles.dart';

import 'package:anime_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/data/datasourses/anime_title_remote_data_source.dart';
import 'core/domain/usecases/get_random_title.dart';
import 'core/platform/network_info.dart';
import 'features/detail/data/datasources/get_title_remote_data_source.dart';
import 'features/detail/data/repositories/get_title_repository_impl.dart';
import 'features/detail/domain/repositories/get_title_repository.dart';
import 'features/detail/domain/usecases/get_title.dart';
import 'features/detail/presentation/bloc/detail_bloc.dart';
import 'features/search/domain/repositories/search_titles.repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features

  // Search
  // Bloc
  sl.registerFactory(() =>
      SearchBloc(getSearchedTitles: sl(), getRandomTitle: sl()));

  // Use cases
  sl.registerLazySingleton<GetSearchedTitles>(
      () => GetSearchedTitles(repository: sl()));

  // Repository
  sl.registerLazySingleton<SearhTitlesRepository>(() =>
      SearchTitlesRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));

  // DataSource
  sl.registerLazySingleton<SearchTitlesRemoteDataSource>(
      () => SearchTitlesRemoteDataSourceImpl(dio: sl()));
  
  // Detail
  // Bloc
  sl.registerFactory(() =>
      DetailBloc(getTitle: sl()));
  
   // Use cases
  sl.registerLazySingleton<GetTitle>(
    () => GetTitle(repository: sl()));
  
   // Repository
  sl.registerLazySingleton<GetTitleRepository>(() =>
      GetTitleRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()));
  // DataSource
  sl.registerLazySingleton<GetTitleRemoteDataSource>(
      () => GetTitleRemoteDataSourceImpl(dio: sl()));

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

  

  //! External
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(baseUrl: Host.apiHost),
      ));
}
