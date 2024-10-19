// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/data/repositories/anilibria_releases_repository.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/helpers/getResponseOrFailure.dart';

class GetUnderseenReleases extends UseCaseFuture<List<Release>, Params> {
  final AnilibriaReleasesRepository repository;
  GetUnderseenReleases({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Release>>> call(params) async {
    return getResponseOrFailure<List<Release>>(() async {
      final underseenReleases = <Release>[];
      for (int id in params.releasesId) {
        underseenReleases.add(await repository.getRelease(id));
      }
      return underseenReleases;
    });
  }
}

class Params extends Equatable {
  final List<int> releasesId;
  const Params({
    required this.releasesId,
  });

  @override
  List<Object?> get props => [releasesId];
}
