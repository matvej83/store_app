import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductsUtils.filterCategoriesBySearchTerm', () {
    final categories = [
      const CategoryEntity(id: '1', name: 'Electronics', image: '', slug: ''),
      const CategoryEntity(id: '2', name: 'Books', image: '', slug: ''),
      const CategoryEntity(id: '3', name: 'Clothing', image: '', slug: ''),
    ];

    test('returns original list when search term is null', () {
      final result = ProductsUtils.filterCategoriesBySearchTerm(categories, null);
      expect(result, categories);
    });

    test('returns original list when search term is empty', () {
      final result = ProductsUtils.filterCategoriesBySearchTerm(categories, '');
      expect(result, categories);
    });

    test('filters categories case-insensitively', () {
      final result = ProductsUtils.filterCategoriesBySearchTerm(categories, 'book');
      expect(result.length, 1);
      expect(result.first.name, 'Books');
    });

    test('returns empty list when no matches', () {
      final result = ProductsUtils.filterCategoriesBySearchTerm(categories, 'food');
      expect(result, isEmpty);
    });
  });
}
