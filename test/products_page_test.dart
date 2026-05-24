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
import 'package:store_app/features/products/presentation/pages/products_page.dart';
import 'package:store_app/features/products/presentation/widgets/filter_modal.dart';

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
    mockProductsBloc.close();
  });

  testWidgets('ProductsPage displays product information when loaded', (
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
    // Provide product via products list
    when(
      () => mockProductsBloc.state,
    ).thenReturn(ProductsState(products: [testProduct], isLoading: false));
    // Make the bloc emit the state when listened to
    when(() => mockProductsBloc.stream).thenAnswer(
      (_) => Stream.value(
        ProductsState(products: [testProduct], isLoading: false),
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
        child: BlocProvider<ProductsBloc>.value(
          value: mockProductsBloc,
          child: const MaterialApp(home: ProductsPage()),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Verify title and price are displayed (description not shown in grid item)
    expect(find.text('Test Product'), findsOneWidget);
    expect(find.text('\$20'), findsOneWidget);
  });

  testWidgets('ProductsPage shows loading indicator when product is loading', (
    WidgetTester tester,
  ) async {
    // Use isLoading to trigger full page loader
    when(
      () => mockProductsBloc.state,
    ).thenReturn(const ProductsState(isLoading: true));
    when(
      () => mockProductsBloc.stream,
    ).thenAnswer((_) => Stream.value(const ProductsState(isLoading: true)));

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: BlocProvider<ProductsBloc>.value(
          value: mockProductsBloc,
          child: const MaterialApp(home: ProductsPage()),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
    'ProductsPage displays empty state when no products are available',
    (WidgetTester tester) async {
      when(
        () => mockProductsBloc.state,
      ).thenReturn(const ProductsState(products: [], isProductLoading: false));
      when(() => mockProductsBloc.stream).thenAnswer(
        (_) => Stream.value(
          const ProductsState(products: [], isProductLoading: false),
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
          child: BlocProvider<ProductsBloc>.value(
            value: mockProductsBloc,
            child: const MaterialApp(home: ProductsPage()),
          ),
        ),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('No products available'), findsOneWidget);
    },
  );

  testWidgets('ProductsPage executes search when typing in search bar', (
    WidgetTester tester,
  ) async {
    final testSearchQuery = 'test search';
    when(
      () => mockProductsBloc.state,
    ).thenReturn(const ProductsState(products: [], isProductLoading: false));
    when(() => mockProductsBloc.stream).thenAnswer(
      (_) => Stream.value(
        const ProductsState(products: [], isProductLoading: false),
      ),
    );
    when(() => mockProductsBloc.add(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: BlocProvider<ProductsBloc>.value(
          value: mockProductsBloc,
          child: const MaterialApp(home: ProductsPage()),
        ),
      ),
    );

    await tester.pump();
    await tester.enterText(find.byType(TextField), testSearchQuery);
    await tester.pump();

    verify(
      () =>
          mockProductsBloc.add(ProductsSearchStarted(search: testSearchQuery)),
    ).called(1);
  });

  testWidgets('ProductsPage opens filter modal when filter button is tapped', (
    WidgetTester tester,
  ) async {
    when(
      () => mockProductsBloc.state,
    ).thenReturn(const ProductsState(filters: [], isProductLoading: false));
    when(() => mockProductsBloc.stream).thenAnswer(
      (_) => Stream.value(
        const ProductsState(filters: [], isProductLoading: false),
      ),
    );
    when(() => mockProductsBloc.add(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: BlocProvider<ProductsBloc>.value(
          value: mockProductsBloc,
          child: const MaterialApp(home: ProductsPage()),
        ),
      ),
    );

    await tester.pump();
    await tester.tap(find.byIcon(Icons.filter_alt_outlined));
    await tester.pumpAndSettle();

    // Verify that the filter dialog is displayed
    expect(find.byType(FilterModal), findsOneWidget);
  });

  testWidgets('ProductsPage handles scroll to load more products', (
    WidgetTester tester,
  ) async {
    final manyProducts = List.generate(
      20,
      (i) => ProductEntity(
        id: i.toString(),
        title: 'Product $i',
        slug: 'product-$i',
        price: i,
        description: 'Description $i',
        category: CategoryEntity(
          id: 'cat$i',
          name: 'Category $i',
          slug: 'category-$i',
          image: 'cat_image.jpg',
        ),
        images: const ['image1.jpg'],
        updatedAt: DateTime(2024, 1, 1),
      ),
    );

    when(
      () => mockProductsBloc.state,
    ).thenReturn(ProductsState(products: manyProducts, isLoading: false));

    when(() => mockProductsBloc.stream).thenAnswer(
      (_) =>
          Stream.value(ProductsState(products: manyProducts, isLoading: false)),
    );

    when(() => mockProductsBloc.add(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ru')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        useOnlyLangCode: true,
        child: BlocProvider<ProductsBloc>.value(
          value: mockProductsBloc,
          child: const MaterialApp(home: ProductsPage()),
        ),
      ),
    );

    await tester.pump();

    await tester.dragUntilVisible(
      find.text('Product 19'),
      find.byType(CustomScrollView),
      const Offset(0, -300),
    );

    await tester.pump(const Duration(milliseconds: 300));

    verify(
      () => mockProductsBloc.add(const NextProductsFetched()),
    ).called(greaterThanOrEqualTo(1));
  });
}
