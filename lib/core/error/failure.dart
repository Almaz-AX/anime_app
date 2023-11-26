import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // const Failure([List properties = const <dynamic>[]]) : super(props);
}


class ServerFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CasheFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DatabaseFailure extends Failure{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}