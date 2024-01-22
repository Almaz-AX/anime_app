import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/features/home/data/models/title_updates.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class GetTitleUpdates extends UseCaseFuture {
  final HomeRepository repository;
  GetTitleUpdates({
    required this.repository,
  });

  @override
  Future<Either<Failure, TitleUpdates>> call(params) {
    return repository.getUpdates(params.page);
  }
}

class Params extends Equatable {
  final int page;
  const Params({
    required this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [page];
}
