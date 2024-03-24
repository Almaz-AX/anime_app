import 'dart:io';

import 'package:anime_app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../error/failure.dart';

Future<Either<Failure, T>> getResponseOrFailure<T>(
    Future<T> Function() response) async {
  try {
    return Right(await response());
  } on NetworkException catch (e) {
    switch (e.type) {
      case NetworkExceptionType.unauthorized:
        return Left(NetworkUnauthorizedFailure());
      case NetworkExceptionType.noInternetConnection:
        return Left(NetworkInternetConnectionFailure());
      case NetworkExceptionType.notFound:
        return Left(NetworkNotFoundFailure());
      case NetworkExceptionType.unexpected:
        return Left(NetworkUnexpectedFailure());
    }
  } on SocketException {
    return Left(NetworkInternetConnectionFailure());
  }
}
