import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/src/features/catalog/presentation/widgets/product_card.dart';

import '../../../../helpers/test_data.dart';

void main() {
  testWidgets('ProductCard shows title and price and handles taps', (tester) async {
    final product = makeProduct(price: 55.5, title: 'Headphones');
    var tapped = false;
    var addTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ProductCard(
          product: product,
          onTap: () => tapped = true,
          onAddToCart: () => addTapped = true,
        ),
      ),
    );

    expect(find.text('Headphones'), findsOneWidget);
    expect(find.text('55.50 EUR'), findsOneWidget);

    await tester.tap(find.byType(ProductCard));
    await tester.pump();
    expect(tapped, isTrue);

    await tester.tap(find.text('Ajouter'));
    await tester.pump();
    expect(addTapped, isTrue);
  });
}
