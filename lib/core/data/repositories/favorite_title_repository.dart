// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/core/data/local/DAO/favorite_title_dao.dart';

import '../../error/failure.dart';
import '../local/entity/favorite_title.dart';

abstract class FavoriteTitleRepository {
  Future<Either<Failure, FavoriteTitle?>> getTitle(int titleId);
  Future<Either<Failure, int>> removeTitle(int titleId);
  Future<Either<Failure, int>> addTitle(int titleId);
  Stream<List<FavoriteTitle>> listenTitles();
}

class FavoriteTitleRepositoryImpl implements FavoriteTitleRepository {
  final FavoriteTitlesDAO favioriteTitlesDAO;
  FavoriteTitleRepositoryImpl({
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
  Future<Either<Failure, int>> addTitle(int titleId) async {
    return await _response<int>(() => favioriteTitlesDAO.addTitle(titleId));
  }

  @override
  Future<Either<Failure, FavoriteTitle?>> getTitle(int titleId) async {
    return await _response<FavoriteTitle?>(
        () => favioriteTitlesDAO.getTitle(titleId));
  }

  @override
  Future<Either<Failure, int>> removeTitle(int titleId) async {
    return await _response<int>(() => favioriteTitlesDAO.removeTitle(titleId));
  }

  @override
  Stream<List<FavoriteTitle>> listenTitles() =>
      favioriteTitlesDAO.listenTitles();
}
