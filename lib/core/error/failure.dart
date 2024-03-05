import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class DatabaseFailure extends Failure {
  @override
  List<Object?> get props => [];
}

enum NetworkFailureTyp {
  noInternetConnection,
  unauthorized,
  notFound,
  // requestTimeout,
  // sendTimeout,
  unexpected,
}

class NetworkUnauthorizedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkInternetConnectionFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkNotFoundFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkUnexpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}
