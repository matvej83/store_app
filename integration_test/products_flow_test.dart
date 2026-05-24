import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:store_app/core/presentation/widgets/app_text_form_field.dart';
import 'package:store_app/features/products/presentation/widgets/product_item.dart';
import 'package:store_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Products pagination flow', (tester) async {
    // run app
    app.main();
    await tester.pumpAndSettle();

    // wait for login screen
    while (find.byType(AppTextFormField).evaluate().isEmpty) {
      await tester.pump(const Duration(milliseconds: 300));
    }

    await tester.enterText(
      find.byType(AppTextFormField).at(0),
      'john@mail.com',
    );
    await tester.enterText(find.byType(AppTextFormField).at(1), 'changeme');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // wait for list
    expect(find.byType(CustomScrollView), findsOneWidget);

    // initial count
    final initial = find.byType(ProductItem).evaluate().length;

    // scroll to trigger pagination
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -1200));
    await tester.pump(const Duration(seconds: 2));

    // allow loading
    await tester.pumpAndSettle(const Duration(seconds: 2));

    final updated = find.byType(ProductItem).evaluate().length;

    expect(updated, greaterThan(initial));
  });
}
