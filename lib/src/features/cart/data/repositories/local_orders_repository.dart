import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/order.dart';
import '../../domain/repositories/orders_repository.dart';

class LocalOrdersRepository implements OrdersRepository {
  LocalOrdersRepository({Box<dynamic>? box}) : _box = box ?? Hive.box(_boxName);

  static const String _boxName = 'ordersBox';
  final Box<dynamic> _box;

  static Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox(_boxName);
    }
  }

  @override
  Future<void> saveOrder(Order order) async {
    await _box.add(order.toMap());
  }

  @override
  Future<List<Order>> fetchOrders() async {
    final values = _box.values.toList();
    final orders = values
        .map((raw) {
          if (raw is Map) {
            return Order.fromMap(Map<String, dynamic>.from(raw));
          }
          return null;
        })
        .whereType<Order>()
        .toList();
    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return orders;
  }
}
