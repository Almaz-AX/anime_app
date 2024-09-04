import 'package:dartz/dartz.dart';


import '../../../../core/data/models/release.dart';
import '../../../../core/error/failure.dart';

abstract class GetTitleRepository {
   Future<Either<Failure, Release>> getTitle(int id);
}