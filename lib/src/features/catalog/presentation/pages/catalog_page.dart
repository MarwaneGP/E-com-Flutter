import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../cart/presentation/viewmodels/cart_view_model.dart';
import 'package:flutter_application_1/src/core/widgets/shop_scaffold.dart';
import '../viewmodels/catalog_view_model.dart';
import '../widgets/product_card.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CatalogViewModel>().loadProducts());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogViewModel>();
    final cart = context.watch<CartViewModel>();

    return ShopScaffold(
      title: 'Catalogue',
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () => context.go('/cart'),
        ),
      ],
      body: RefreshIndicator(
        onRefresh: catalog.refresh,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Recherche un produit...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            catalog.search('');
                            setState(() {});
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
                onChanged: (value) {
                  catalog.search(value);
                  setState(() {});
                },
              ),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  if (catalog.isLoading && !catalog.isLoaded) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final products = catalog.products;
                  if (products.isEmpty) {
                    return const Center(child: Text('Aucun produit trouve'));
                  }

                  return ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => context.go('/product/${product.id}'),
                        onAddToCart: () {
                          cart.add(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} ajoute au panier'),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

