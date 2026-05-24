import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:store_app/features/products/domain/entity/category_entity.dart';
import 'package:store_app/features/products/domain/entity/product_entity.dart';
import 'package:store_app/features/products/presentation/bloc/products_bloc.dart';
import 'package:store_app/features/products/presentation/bloc/products_event.dart';
import 'package:store_app/features/products/presentation/bloc/products_state.dart';
import 'package:store_app/features/products/presentation/pages/product_page.dart';

class FakeProductsEvent extends Fake implements ProductsEvent {}

class MockProductsBloc extends Mock implements ProductsBloc {}

void main() {
  setUpAll(() async {
    registerFallbackValue(FakeProductsEvent());
    await initializeDateFormatting('en', null);
  });
  late MockProductsBloc mockProductsBloc;

  setUp(() {
    mockProductsBloc = MockProductsBloc();
    // Stub the stream getter to return an empty stream by default
    when(() => mockProductsBloc.stream).thenAnswer((_) => const Stream.empty());
    // Stub the state getter
    when(() => mockProductsBloc.state).thenReturn(const ProductsState());
    // Stub add to do nothing
    when(() => mockProductsBloc.add(any())).thenAnswer((_) {});
    // Stub close to return a completed future
    when(() => mockProductsBloc.close()).thenAnswer((_) async {});
  });

  tearDown(() {
    // No need to call close as it's already stubbed, but keep for clarity
    mockProductsBloc.close();
  });

  testWidgets('ProductPage displays product information when loaded', (
    WidgetTester tester,
  ) async {
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

    // Set up the state to return the loaded product
    when(
      () => mockProductsBloc.state,
    ).thenReturn(ProductsState(product: testProduct, isProductLoading: false));
    // Make the bloc emit the state when listened to
    when(() => mockProductsBloc.stream).thenAnswer(
      (_) => Stream.value(
        ProductsState(product: testProduct, isProductLoading: false),
      ),
    );

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: MaterialApp(
          home: BlocProvider<ProductsBloc>.value(
            value: mockProductsBloc,
            child: const ProductPage(id: '1'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text(testProduct.title), findsOneWidget);
    expect(find.text('\$${testProduct.price}'), findsOneWidget);
    expect(find.text(testProduct.description), findsOneWidget);
  });

  testWidgets('ProductPage shows loading indicator when product is loading', (
    WidgetTester tester,
  ) async {
    when(
      () => mockProductsBloc.state,
    ).thenReturn(const ProductsState(isProductLoading: true));
    when(() => mockProductsBloc.stream).thenAnswer(
      (_) => Stream.value(const ProductsState(isProductLoading: true)),
    );

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: MaterialApp(
          home: BlocProvider<ProductsBloc>.value(
            value: mockProductsBloc,
            child: const ProductPage(id: '1'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
