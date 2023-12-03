// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:anime_app/features/search/data/models/search_titles.dart';
import 'package:anime_app/features/search/domain/repositories/search_titles.repository.dart';

import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';

class GetSearchedTitles extends UseCaseFuture<SearchTitles, Params> {
  final SearhTitlesRepository repository;
  GetSearchedTitles({
    required this.repository,
  });
  @override
  Future<Either<Failure, SearchTitles>> call(Params params) async {
    return await repository.getSearchedTitles(params.query, params.page);
  }
}

class Params extends Equatable {
  final String query;
  final int page;
  const Params({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}
