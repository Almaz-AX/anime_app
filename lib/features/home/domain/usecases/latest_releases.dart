import 'package:anime_app/core/data/models/release.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class LatesetReleases extends UseCaseFuture {
  final HomeRepository repository;
  LatesetReleases({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Release>>> call(params) {
    return repository.latestReleases(params.limit);
  }
}

class Params extends Equatable {
  final int? limit;
  const Params({
    this.limit,
  });

  @override
  List<Object?> get props => [limit];
}
