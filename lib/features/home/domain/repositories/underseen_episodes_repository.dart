// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import "../../data/datasources/underseen_episodes_local_data_source.dart";

import '../../../../core/data/local/entity/watched_episode.dart';

abstract class UnderseenEpisodesRepository {
  listenHistory();
}

class UnderseenEpisodesRepositoryImpl implements UnderseenEpisodesRepository {
  final UnderseenEpisodesLocalDataSource dataSource;
  UnderseenEpisodesRepositoryImpl({required this.dataSource});

  @override
  Stream<List<WatchedEpisode>> listenHistory() =>
      dataSource.listenUnderseenEpisodesHistory();
}
