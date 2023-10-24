// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../error/expetions.dart';
import '../../error/failure.dart';
import '../../platform/network_info.dart';
import '../datasourses/anime_title_remote_data_source.dart';
import '../models/anime_title.dart';

abstract class AnimeTitleRepository {
  Future<Either<Failure, AnimeTitle>> getRandomTitle();
}

class AnimeTitleRepositoryImpl implements AnimeTitleRepository {
  final NetworkInfo networkInfo;
  final AnimeTitleRemoteDataSource remoteDataSource;
  AnimeTitleRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo
  });

  @override
  Future<Either<Failure, AnimeTitle>> getRandomTitle() async {
    try {
      final remoteAnimeTitles = await remoteDataSource.getRandomTitle();
      return Right(remoteAnimeTitles);
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
}
