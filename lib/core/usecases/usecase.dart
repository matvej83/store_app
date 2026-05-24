import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

abstract class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {}
