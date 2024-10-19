// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/domain/usecases/usecase.dart';
import 'package:anime_app/features/home/domain/repositories/home_repository.dart';
import '../../../../core/data/local/entity/watched_episode.dart';

class GetUnderseenEpisodes extends UseCaseStream {
  final LocalRepository repository;
  GetUnderseenEpisodes({
    required this.repository,
  });
  @override
  Stream<List<WatchedEpisode>> call(params) {
    return repository.listenUnderseenEpisodes();
  }
}

class NoParams {}
