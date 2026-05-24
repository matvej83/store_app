import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/domain/entity/product_entity.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class FetchProductsUseCase
    implements UseCase<List<ProductEntity>, FetchProductsParams> {
  FetchProductsUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
    FetchProductsParams params,
  ) async {
    return await repository.fetchProducts(
      categoryId: params.categoryId,
      search: params.search,
      priceMin: params.priceMin,
      priceMax: params.priceMax,
      offset: params.offset,
      limit: params.limit,
    );
  }
}

class FetchProductsParams {
  FetchProductsParams({
    this.categoryId,
    this.search,
    this.priceMin,
    this.priceMax,
    this.offset,
    this.limit,
  });

  final String? categoryId;
  final String? search;
  final int? priceMin;
  final int? priceMax;
  final int? offset;
  final int? limit;
}
