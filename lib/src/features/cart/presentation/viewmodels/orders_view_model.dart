import 'package:flutter/foundation.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';

class OrdersViewModel extends ChangeNotifier {
  OrdersViewModel(this._repository);

  final OrdersRepository _repository;
  List<Order> _orders = [];
  bool isLoading = false;

  List<Order> get orders => _orders;

  Future<void> loadOrders() async {
    isLoading = true;
    notifyListeners();
    try {
      _orders = await _repository.fetchOrders();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
