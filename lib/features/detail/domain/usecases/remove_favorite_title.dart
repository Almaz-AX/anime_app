import 'package:dartz/dartz.dart';

import '../../../favorites/domain/repositories/favorite_release_repository.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import 'get_title.dart';

class RemoveFavoriteTitle extends UseCaseFuture<int, Params> {
  final FavoriteReleaseRepository repository;
  RemoveFavoriteTitle({
    required this.repository,
  });

  @override
  Future<Either<Failure, int>> call(Params params) async {
    return await repository.removeRelease(params.id);
  }
}
