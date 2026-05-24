import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:store_app/core/error/failure.dart';
import 'package:store_app/core/usecases/usecase.dart';
import 'package:store_app/features/products/domain/entity/app_image_entity.dart';
import 'package:store_app/features/products/domain/entity/image_entity.dart';
import 'package:store_app/features/products/domain/repository/products_repository.dart';

@lazySingleton
class UploadImageUseCase implements UseCase<ImageEntity, UploadImageParams> {
  UploadImageUseCase(this.repository);

  final ProductsRepository repository;

  @override
  Future<Either<Failure, ImageEntity>> call(UploadImageParams params) async {
    return await repository.uploadImage(imageFile: params.image);
  }
}

class UploadImageParams {
  UploadImageParams({required this.image});

  final AppImageEntity image;
}
