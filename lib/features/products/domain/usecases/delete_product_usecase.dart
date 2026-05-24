import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class DeleteProductUseCase implements UseCase<bool, DeleteProductParams> {
  DeleteProductUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, bool>> call(DeleteProductParams params) async {
    return await repository.deleteProduct(id: params.id);
  }
}

class DeleteProductParams {
  DeleteProductParams({required this.id});

  final int id;
}
