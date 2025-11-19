import '../../../catalog/domain/entities/product.dart';

class CartItem {
  CartItem({required this.product, this.quantity = 1});

  final Product product;
  int quantity;

  double get subtotal => product.price * quantity;

  Map<String, dynamic> toMap() => {
        'product': product.toMap(),
        'quantity': quantity,
      };

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(Map<String, dynamic>.from(map['product'] ?? {})),
      quantity: (map['quantity'] as num?)?.toInt() ?? 1,
    );
  }
}
