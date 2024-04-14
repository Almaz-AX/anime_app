// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:anime_app/core/data/datasourses/get_titles_remote_data_source.dart';
import 'package:anime_app/core/error/failure.dart';
import 'package:anime_app/core/helpers/getResponseOrFailure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/core/data/models/anime_title.dart';
import '../../../../core/domain/usecases/usecase.dart';

class GetUnderseenTitles extends UseCaseFuture {
  final GetTitlesRemoteDataSource repository;
  GetUnderseenTitles({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<AnimeTitle>>> call(params) async {
    return getResponseOrFailure(
        () async => await repository.getTitles(params.titlesId));
  }
}

class Params extends Equatable {
  final List<int> titlesId;
  const Params({
    required this.titlesId,
  });

  @override
  List<Object?> get props => [titlesId];
}
