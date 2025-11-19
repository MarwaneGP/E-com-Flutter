import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/src/features/catalog/domain/entities/product.dart';
import 'package:flutter_application_1/src/features/catalog/domain/repositories/catalog_repository.dart';
import 'package:flutter_application_1/src/features/catalog/presentation/viewmodels/catalog_view_model.dart';

import '../../helpers/test_data.dart';

class FakeCatalogRepository implements CatalogRepository {
  FakeCatalogRepository(this._products);

  final List<Product> _products;

  @override
  Future<List<Product>> fetchProducts() async => _products;

  @override
  Future<Product> fetchProduct(String id) async =>
      _products.firstWhere((product) => product.id == id);
}

void main() {
  late CatalogViewModel viewModel;
  late FakeCatalogRepository repository;

  setUp(() {
    repository = FakeCatalogRepository([
      makeProduct(id: '1', title: 'Sneaker'),
      makeProduct(id: '2', title: 'Watch'),
    ]);
    viewModel = CatalogViewModel(repository);
  });

  test('loadProducts populates products and marks as loaded', () async {
    expect(viewModel.isLoaded, isFalse);

    await viewModel.loadProducts();

    expect(viewModel.isLoaded, isTrue);
    expect(viewModel.products, hasLength(2));
    expect(viewModel.isLoading, isFalse);
  });

  test('search filters products by title', () async {
    await viewModel.loadProducts();

    viewModel.search('watch');

    expect(viewModel.products, hasLength(1));
    expect(viewModel.products.first.title, contains('Watch'));

    viewModel.search('non-existent');
    expect(viewModel.products, isEmpty);
  });
}
