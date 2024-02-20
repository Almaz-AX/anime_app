import 'package:anime_app/core/error/expetions.dart';
import 'package:dartz/dartz.dart';

import '../error/failure.dart';

Future<Either<Failure, T>> getResponseOrFailure<T>(
    Future<T> Function() response, bool networkIsConnected) async {
  if (networkIsConnected) {
    try {
      return Right(await response());
    } on ServerExeption {
      return Left(ServerFailure());
    }
  }
  return Left(NetworkConnectionFailure());
}
