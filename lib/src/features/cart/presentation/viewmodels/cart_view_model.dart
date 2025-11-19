import 'package:flutter/foundation.dart';

import '../../../catalog/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';

class CartViewModel extends ChangeNotifier {
  CartViewModel(this._ordersRepository);

  final OrdersRepository _ordersRepository;
  final Map<String, CartItem> _items = {};
  bool isCheckoutInProgress = false;

  List<CartItem> get items => _items.values.toList();
  bool get isEmpty => _items.isEmpty;
  double get total => _items.values.fold(
        0,
        (previousValue, item) => previousValue + item.subtotal,
      );

  void add(Product product) {
    final existing = _items[product.id];
    if (existing != null) {
      existing.quantity += 1;
    } else {
      _items[product.id] = CartItem(product: product, quantity: 1);
    }
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product.id);
    notifyListeners();
  }

  void decrease(Product product) {
    final existing = _items[product.id];
    if (existing == null) return;
    if (existing.quantity > 1) {
      existing.quantity -= 1;
    } else {
      _items.remove(product.id);
    }
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    if (quantity <= 0) {
      _items.remove(product.id);
    } else {
      _items.putIfAbsent(product.id, () => CartItem(product: product, quantity: quantity));
      _items[product.id]!.quantity = quantity;
    }
    notifyListeners();
  }

  Future<Order?> checkout() async {
    if (_items.isEmpty || isCheckoutInProgress) return null;
    isCheckoutInProgress = true;
    notifyListeners();
    try {
      final clonedItems = items
          .map((item) => CartItem(product: item.product, quantity: item.quantity))
          .toList();
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        createdAt: DateTime.now(),
        items: clonedItems,
        total: total,
      );
      await _ordersRepository.saveOrder(order);
      _items.clear();
      return order;
    } catch (e) {
      debugPrint('Checkout failed: ');
      rethrow;
    } finally {
      isCheckoutInProgress = false;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
