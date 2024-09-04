// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:anime_app/core/domain/usecases/get_title_by_id.dart';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/core/data/models/release.dart';

import '../../data/repositories/get_random_title_repository.dart';
import '../../error/failure.dart';
import 'usecase.dart';

class GetRandomReleases implements UseCaseFuture<List<Release>, RandomParams> {
  final GetRandomTitleRepository repository;
  GetRandomReleases({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Release>>> call(RandomParams params) async {
    final releases = await repository.getRandomReleases(params.limit);
    return releases;
  }
}

class RandomParams extends Equatable {
  final int? limit;
  const RandomParams({
    this.limit,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [limit];
}
