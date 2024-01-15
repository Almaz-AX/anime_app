// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/core/data/models/anime_title.dart';
import 'package:anime_app/features/home/domain/repositories/home_repository.dart';

import '../../../../core/domain/usecases/usecase.dart';

class GetUnderseenTitles extends UseCaseFuture {
  final HomeRepository repository;
  GetUnderseenTitles({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<AnimeTitle>>> call(params) async {
    return await repository.getTitles(params.titlesId);
  }
}

class Params extends Equatable {
  final List<int> titlesId;
  const Params({
    required this.titlesId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [titlesId];
}
