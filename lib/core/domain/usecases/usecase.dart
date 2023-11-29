import 'package:dartz/dartz.dart';

import '../../error/failure.dart';

abstract class UseCaseStream<Type, Params> {
  Stream<Type> call(Params params);
}

abstract class UseCaseEither<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
