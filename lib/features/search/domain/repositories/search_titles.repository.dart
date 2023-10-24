import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/models/search_titles.dart';

abstract class SearhTitlesRepository {
  Future<Either<Failure, SearchTitles>> getSearchedTitles(
      String query, int page);
}
