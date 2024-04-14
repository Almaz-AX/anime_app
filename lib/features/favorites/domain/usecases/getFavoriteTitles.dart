// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:anime_app/core/data/repositories/get_titles_repositiry.dart';
import 'package:anime_app/core/domain/usecases/usecase.dart';
import 'package:anime_app/core/error/failure.dart';

import '../../../../core/data/models/anime_title.dart';

class GetFavoriteTitles extends UseCaseFuture<List<AnimeTitle>, Params> {
  final GetTitlesRepository repository;
  GetFavoriteTitles({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<AnimeTitle>>> call(Params params) async {
    return await repository.getTitles(params.titlesId);
  }
}

class Params {
  final List<int> titlesId;
  Params({
    required this.titlesId,
  });
}
