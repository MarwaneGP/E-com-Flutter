import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';

class CatalogViewModel extends ChangeNotifier {
  CatalogViewModel(this._repository);

  final CatalogRepository _repository;
  List<Product> _allProducts = [];
  List<Product> _visibleProducts = [];
  bool _isLoading = false;

  List<Product> get products => _visibleProducts;
  bool get isLoading => _isLoading;
  bool get isLoaded => _allProducts.isNotEmpty;

  Future<void> loadProducts() async {
    if (_isLoading || _allProducts.isNotEmpty) return;
    _setLoading(true);
    try {
      _allProducts = await _repository.fetchProducts();
      _visibleProducts = List<Product>.from(_allProducts);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refresh() async {
    _setLoading(true);
    try {
      _allProducts = await _repository.fetchProducts();
      _visibleProducts = List<Product>.from(_allProducts);
    } finally {
      _setLoading(false);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      _visibleProducts = List<Product>.from(_allProducts);
    } else {
      final lowerQuery = query.toLowerCase();
      _visibleProducts = _allProducts
          .where((product) => product.title.toLowerCase().contains(lowerQuery))
          .toList();
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
