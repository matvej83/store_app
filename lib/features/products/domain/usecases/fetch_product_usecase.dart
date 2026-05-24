import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/domain/entity/product_entity.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class FetchProductUseCase
    implements UseCase<ProductEntity, FetchProductParams> {
  FetchProductUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, ProductEntity>> call(FetchProductParams params) async {
    return await repository.fetchProduct(id: params.id);
  }
}

class FetchProductParams {
  FetchProductParams({this.id});

  final String? id;
}
