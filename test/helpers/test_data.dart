import 'package:flutter_application_1/src/features/catalog/domain/entities/product.dart';
import 'package:flutter_application_1/src/features/cart/domain/entities/cart_item.dart';

Product makeProduct({
  String id = 'p1',
  String title = 'Sample Product',
  double price = 42.0,
}) {
  return Product(
    id: id,
    title: title,
    price: price,
    thumbnail: 'https://example.com/thumb.jpg',
    images: const ['https://example.com/img.jpg'],
    description: 'Description for $title',
    category: 'test',
  );
}

CartItem makeCartItem({Product? product, int quantity = 1}) {
  return CartItem(product: product ?? makeProduct(), quantity: quantity);
}
