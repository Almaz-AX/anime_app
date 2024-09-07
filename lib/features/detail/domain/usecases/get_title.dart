import 'package:anime_app/core/data/repositories/anime_releases_repository.dart';
import 'package:anime_app/core/helpers/getResponseOrFailure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';


class GetTitle extends UseCaseFuture<Release, Params> {
  final AnimeReleasesRepository repository;
  GetTitle({
    required this.repository,
  });
  @override
  Future<Either<Failure, Release>> call(Params params) async {
    return getResponseOrFailure(
        () async => await repository.getRelease(params.id));
  }
}

class Params extends Equatable {
  final int id;
  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
