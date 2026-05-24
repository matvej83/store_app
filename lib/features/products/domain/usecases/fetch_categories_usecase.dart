import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/domain/entity/category_entity.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class FetchCategoriesUseCase
    implements UseCase<List<CategoryEntity>, NoParams> {
  FetchCategoriesUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, List<CategoryEntity>>> call(NoParams params) async {
    return await repository.fetchCategories();
  }
}
