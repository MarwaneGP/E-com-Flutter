import '../entities/order.dart';

abstract class OrdersRepository {
  Future<void> saveOrder(Order order);
  Future<List<Order>> fetchOrders();
}
