// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:anime_app/features/favorites/domain/repositories/favorite_release_repository.dart';
import 'package:anime_app/core/domain/usecases/usecase.dart';
import 'package:anime_app/core/error/failure.dart';

import '../../../../core/data/local/entity/favorite_title.dart';
import 'get_title.dart';

class GetFavoriteTitle extends UseCaseFuture<FavoriteTitle?, Params> {
  final FavoriteReleaseRepository repository;
  GetFavoriteTitle({
    required this.repository,
  });

  @override
  Future<Either<Failure, FavoriteTitle?>> call(Params params) async {
    return await repository.getRelease(params.id);
  }
}
