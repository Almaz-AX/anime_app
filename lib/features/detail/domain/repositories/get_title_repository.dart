import 'package:dartz/dartz.dart';

import '../../../../core/data/models/anime_title.dart';
import '../../../../core/error/failure.dart';

abstract class GetTitleRepository {
   Future<Either<Failure, AnimeTitle>> getTitle(int id);
}