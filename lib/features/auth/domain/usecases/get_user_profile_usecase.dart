import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/auth/domain/entity/user_entity.dart';
import 'package:store_app/features/auth/domain/repository/auth_repository.dart';

@lazySingleton
class GetUserProfileUseCase implements UseCase<UserEntity?, NoParams> {
  GetUserProfileUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntity?>> call(NoParams params) async {
    return await repository.getUserProfile();
  }
}
