import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/data/models/category_model.dart';
import 'package:store_app/features/products/domain/entity/category_entity.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class CreateCategoryUseCase
    implements UseCase<CategoryEntity, CreateCategoryParams> {
  CreateCategoryUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, CategoryEntity>> call(
    CreateCategoryParams params,
  ) async {
    return await repository.createCategory(category: params.category);
  }
}

class CreateCategoryParams {
  CreateCategoryParams({required this.category});

  final CategoryModel category;
}
