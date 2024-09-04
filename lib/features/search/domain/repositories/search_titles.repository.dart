import 'package:anime_app/core/data/models/release.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class SearhTitlesRepository {
  Future<Either<Failure, List<Release>>> getSearchedTitles(String query);
}
