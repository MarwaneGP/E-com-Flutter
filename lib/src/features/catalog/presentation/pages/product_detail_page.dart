import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../cart/presentation/viewmodels/cart_view_model.dart';
import 'package:flutter_application_1/src/core/widgets/shop_scaffold.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../viewmodels/product_detail_view_model.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductDetailViewModel>(
      create: (context) => ProductDetailViewModel(
        context.read<CatalogRepository>(),
        productId: productId,
      )..loadProduct(),
      child: _ProductDetailBody(productId: productId),
    );
  }
}

class _ProductDetailBody extends StatelessWidget {
  const _ProductDetailBody({required this.productId});

  final String productId;

  bool get _isAndroidShare => !kIsWeb && Platform.isAndroid;

  Future<void> _shareProduct(ProductDetailViewModel vm) async {
    final product = vm.product;
    if (product == null) return;
    final message =
        'Decouvre ${product.title} pour ${product.price.toStringAsFixed(2)} EUR sur ShopFlutter';
    await Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductDetailViewModel>();
    final cart = context.watch<CartViewModel>();
    final product = vm.product;

    return ShopScaffold(
      title: product?.title ?? 'Produit $productId',
      actions: [
        if (product != null && _isAndroidShare)
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareProduct(vm),
            tooltip: 'Partager via Android Share Intent',
          ),
      ],
      floatingActionButton: product == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                cart.add(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} ajoute au panier'),
                    action: SnackBarAction(
                      label: 'Voir panier',
                      onPressed: () => context.go('/cart'),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Ajouter'),
            ),
      body: Builder(
        builder: (context) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null || product == null) {
            return Center(
              child: Text(vm.error ?? 'Produit introuvable'),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SizedBox(
                height: 260,
                child: PageView(
                  children: product.images
                      .map(
                        (img) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              img,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const ColoredBox(
                                color: Colors.black12,
                                child: Center(child: Icon(Icons.image_not_supported)),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.price.toStringAsFixed(2)} EUR',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 16),
              Text(product.description),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () {
                  cart.add(product);
                  context.go('/cart');
                },
                child: const Text('Acheter maintenant'),
              ),
            ],
          );
        },
      ),
    );
  }
}
