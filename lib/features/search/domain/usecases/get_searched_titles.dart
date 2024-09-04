// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/data/models/release.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../../../../core/error/failure.dart';
import '../repositories/search_titles.repository.dart';

class GetSearchedTitles extends UseCaseFuture<List<Release>, Params> {
  final SearhTitlesRepository repository;
  GetSearchedTitles({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Release>>> call(Params params) async {
    return await repository.getSearchedTitles(params.query);
  }
}

class Params extends Equatable {
  final String query;
  final int page;
  const Params({required this.query, this.page = 1});

  @override
  List<Object?> get props => [query, page];
}
