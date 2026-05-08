import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_test/features/products/domain/entity/category_entity.dart';
import 'package:clean_architecture_test/features/products/domain/entity/product_entity.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_event.dart';
import 'package:clean_architecture_test/features/products/presentation/bloc/products_state.dart';
import 'package:clean_architecture_test/features/products/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockProductsBloc extends MockBloc<ProductsEvent, ProductsState> {}

void main() {
  late MockProductsBloc mockProductsBloc;

  setUp(() {
    mockProductsBloc = MockProductsBloc();
  });

  tearDown(() {
    mockProductsBloc.close();
  });

  testWidgets('ProductPage displays product information when loaded', (
    WidgetTester tester,
  ) async {
    // Arrange: Create test product with all required parameters
    final testProduct = ProductEntity(
      id: '1',
      title: 'Test Product',
      slug: 'test-product',
      price: 20,
      description: 'This is a test product description.',
      category: const CategoryEntity(
        id: 'cat1',
        name: 'Test Category',
        slug: 'test-category',
        image: 'category_image.jpg',
      ),
      images: const ['image1.jpg', 'image2.jpg'],
      updatedAt: DateTime(2024, 1, 1),
    );

    // Mock the bloc to return loaded state
    whenListen(
      mockProductsBloc,
      Stream.value(
        ProductsState(product: testProduct, isProductLoading: false),
      ),
      initialState: const ProductsState(),
    );

    // Build our app and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockProductsBloc,
          child: const ProductPage(id: '1'),
        ),
      ),
    );

    // Wait for all animations to complete
    await tester.pumpAndSettle();

    // Assert: Verify product information is displayed
    expect(find.text(testProduct.title), findsOneWidget);
    expect(find.text('\$${testProduct.price}'), findsOneWidget);
    expect(find.text(testProduct.description), findsOneWidget);
  });

  testWidgets('ProductPage shows loading indicator when product is loading', (
    WidgetTester tester,
  ) async {
    // Arrange: Mock loading state
    whenListen(
      mockProductsBloc,
      Stream.value(const ProductsState(isProductLoading: true)),
      initialState: const ProductsState(),
    );

    // Build widget
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockProductsBloc,
          child: const ProductPage(id: '1'),
        ),
      ),
    );

    // Assert: Loading indicator should be present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
