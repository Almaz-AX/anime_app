// import 'package:anime_app/core/domain/usecases/get_title_by_id.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/anime_title.dart';
import '../../data/repositories/anime_title_repository.dart';
import '../../error/failure.dart';
import 'usecase.dart';

class GetRandomTitle implements UseCase<AnimeTitle, NoParams> {
  final AnimeTitleRepository repository;
 GetRandomTitle({
    required this.repository,
  });

  @override
  Future<Either<Failure, AnimeTitle>> call(NoParams params) async {
    final title = await repository.getRandomTitle();
    return title;
  }
}

class NoParams extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
 
}
