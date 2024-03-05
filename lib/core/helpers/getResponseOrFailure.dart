import 'dart:io';

import 'package:anime_app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import '../error/failure.dart';

Future<Either<Failure, T>> getResponseOrFailure<T>(
    Future<T> Function() response, bool networkIsConnected) async {
  try {
    return Right(await response());
  } on NetworkException catch (e) {
    switch (e.type) {
      case NetworkExceptionType.noInternetConnection:
        return Left(NetworkInternetConnectionFailure());
      default:
        return Left(NetworkUnexpectedFailure());
    }
  } on SocketException {
    return Left(NetworkInternetConnectionFailure());
  }
}
