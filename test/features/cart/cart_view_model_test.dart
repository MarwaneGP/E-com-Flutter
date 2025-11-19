import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_1/src/features/cart/domain/repositories/orders_repository.dart';
import 'package:flutter_application_1/src/features/cart/presentation/viewmodels/cart_view_model.dart';
import 'package:flutter_application_1/src/features/cart/domain/entities/order.dart';
import 'package:flutter_application_1/src/features/cart/domain/entities/cart_item.dart';

import '../../helpers/test_data.dart';

class MockOrdersRepository extends Mock implements OrdersRepository {}



void main() {
  late CartViewModel viewModel;
  late MockOrdersRepository repository;

  setUpAll(() {
    registerFallbackValue(Order(id: 'fallback', createdAt: DateTime.fromMillisecondsSinceEpoch(0), items: <CartItem>[], total: 0));
  });

  setUp(() {
    repository = MockOrdersRepository();
    viewModel = CartViewModel(repository);
  });

  test('add increases quantity and total', () {
    final product = makeProduct(price: 10);

    viewModel.add(product);
    viewModel.add(product);

    expect(viewModel.items, hasLength(1));
    expect(viewModel.items.first.quantity, 2);
    expect(viewModel.total, 20);
  });

  test('checkout saves order and clears cart', () async {
    final product = makeProduct(price: 15);
    when(() => repository.saveOrder(any())).thenAnswer((_) async {});

    viewModel.add(product);

    final order = await viewModel.checkout();

    verify(() => repository.saveOrder(any())).called(1);
    expect(order, isNotNull);
    expect(order!.items.single.product.id, product.id);
    expect(viewModel.items, isEmpty);
  });
}


