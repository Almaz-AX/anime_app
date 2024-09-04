// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/data/local/DAO/favorite_title_dao.dart';

import '../../error/failure.dart';
import '../local/entity/favorite_title.dart';

abstract class FavoriteReleaseRepository {
  Future<Either<Failure, FavoriteTitle?>> getRelease(int titleId);
  Future<Either<Failure, int>> removeRelease(int titleId);
  Future<Either<Failure, int>> addRelease(int titleId);
  Stream<List<FavoriteTitle>> listenReleases();
}

class FavoriteReleaseRepositoryImpl implements FavoriteReleaseRepository {
  final FavoriteTitlesDAO favioriteTitlesDAO;
  FavoriteReleaseRepositoryImpl({
    required this.favioriteTitlesDAO,
  });

  Future<Either<Failure, T>> _response<T>(Future<T> Function() response) async {
    try {
      return Right(await response());
    } catch (e) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> addRelease(int titleId) async {
    return await _response<int>(() => favioriteTitlesDAO.addTitle(titleId));
  }

  @override
  Future<Either<Failure, FavoriteTitle?>> getRelease(int titleId) async {
    return await _response<FavoriteTitle?>(
        () => favioriteTitlesDAO.getTitle(titleId));
  }

  @override
  Future<Either<Failure, int>> removeRelease(int titleId) async {
    return await _response<int>(() => favioriteTitlesDAO.removeTitle(titleId));
  }

  @override
  Stream<List<FavoriteTitle>> listenReleases() =>
      favioriteTitlesDAO.listenTitles();
}
