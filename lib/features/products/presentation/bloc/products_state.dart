import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:store_app/core/domain/entity/availability_filter_entity.dart';
import 'package:store_app/features/products/domain/entity/app_image_entity.dart';
import 'package:store_app/features/products/domain/entity/category_entity.dart';
import 'package:store_app/features/products/domain/entity/product_entity.dart';

part 'products_state.freezed.dart';

@freezed
abstract class ProductsState with _$ProductsState {
  const factory ProductsState({
    @Default(false) bool isLoading,
    @Default(false) bool isProductLoading,

    /// pagination
    @Default(false) bool isShowProductLoader,
    @Default(false) bool hasReachedMaxProducts,

    @Default(false) bool createdSuccessful,
    @Default(false) bool isCreating,
    String? error,
    String? search,
    String? searchCategory,
    String? innerSearchCategory,
    @Default([]) List<ProductEntity> products,
    @Default([]) List<ProductEntity> relatedById,
    ProductEntity? product,
    @Default([]) List<CategoryEntity> categories,
    @Default([]) List<CategoryEntity> categorySearchResults,
    @Default([]) List<CategoryEntity> innerCategorySearchResults,
    @Default('') String selectedCategoryId,
    @Default('') String createdProductCategoryId,
    List<AppImageEntity>? pickedImages,
    List<String>? uploadedImages,
    @Default([]) List<AvailabilityFilterEntity> filters,
  }) = _ProductsState;
}
