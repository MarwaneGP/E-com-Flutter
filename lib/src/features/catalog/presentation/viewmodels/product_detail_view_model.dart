import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';

class ProductDetailViewModel extends ChangeNotifier {
  ProductDetailViewModel(this._repository, {required this.productId});

  final CatalogRepository _repository;
  final String productId;
  Product? product;
  bool isLoading = false;
  String? error;

  Future<void> loadProduct() async {
    if (product != null || isLoading) return;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      product = await _repository.fetchProduct(productId);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
