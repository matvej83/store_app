import 'package:dartz/dartz.dart';
import 'package:store_app/core/error/failure.dart';

import '../../../auth/domain/entity/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, List<UserEntity>>> fetchUsers();

  Future<Either<Failure, UserEntity>> fetchUser({String? id});
}
