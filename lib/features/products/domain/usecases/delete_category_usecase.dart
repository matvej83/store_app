import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class DeleteCategoryUseCase implements UseCase<bool, DeleteCategoryParams> {
  DeleteCategoryUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, bool>> call(DeleteCategoryParams params) async {
    return await repository.deleteCategory(id: params.id);
  }
}

class DeleteCategoryParams {
  DeleteCategoryParams({required this.id});

  final int id;
}
