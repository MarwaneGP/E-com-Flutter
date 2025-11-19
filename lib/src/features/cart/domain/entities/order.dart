import 'cart_item.dart';

class Order {
  Order({
    required this.id,
    required this.createdAt,
    required this.items,
    required this.total,
  });

  final String id;
  final DateTime createdAt;
  final List<CartItem> items;
  final double total;

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'items': items.map((item) => item.toMap()).toList(),
        'total': total,
      };

  factory Order.fromMap(Map<String, dynamic> map) {
    final rawItems = map['items'] as List<dynamic>? ?? [];
    return Order(
      id: map['id']?.toString() ?? '',
      createdAt: DateTime.tryParse(map['createdAt'] ?? '') ?? DateTime.now(),
      items: rawItems
          .map((raw) => CartItem.fromMap(Map<String, dynamic>.from(raw)))
          .toList(),
      total: (map['total'] as num?)?.toDouble() ?? 0,
    );
  }
}
