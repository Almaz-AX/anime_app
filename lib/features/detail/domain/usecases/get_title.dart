import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


import '../../../../core/data/models/release.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/get_title_repository.dart';

class GetTitle extends UseCaseFuture<Release, Params> {
  final GetTitleRepository repository;
  GetTitle({
    required this.repository,
  });
  @override
  Future<Either<Failure, Release>> call(Params params) async {
    return await repository.getTitle(params.id);
  }
}

class Params extends Equatable {
  final int id;
  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
