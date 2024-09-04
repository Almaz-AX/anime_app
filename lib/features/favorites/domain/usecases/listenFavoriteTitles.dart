// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app/core/data/local/entity/favorite_title.dart';
import 'package:anime_app/core/data/repositories/favorite_release_repository.dart';
import 'package:anime_app/core/domain/usecases/usecase.dart';

class ListenFavoriteTitles
    extends UseCaseStream<List<FavoriteTitle>, NoParams> {
  final FavoriteReleaseRepository repository;
  ListenFavoriteTitles({
    required this.repository,
  });

  @override
  Stream<List<FavoriteTitle>> call(params) => repository.listenReleases();
}

class NoParams {}
