import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/src/core/widgets/shop_scaffold.dart';
import '../../domain/entities/cart_item.dart';
import '../viewmodels/cart_view_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();
    final items = cart.items;

    return ShopScaffold(
      title: 'Panier',
      body: items.isEmpty
          ? const Center(child: Text('Votre panier est vide'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      final item = items[index];
                      return _CartItemTile(item: item);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontSize: 18)),
                          Text('${cart.total.toStringAsFixed(2)} EUR',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: () => context.go('/checkout'),
                        child: const Text('Passer au checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  const _CartItemTile({required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartViewModel>();
    final product = item.product;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.thumbnail,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const ColoredBox(
              color: Colors.black12,
              child: SizedBox(width: 56, height: 56),
            ),
          ),
        ),
        title: Text(product.title),
        subtitle: Text('${product.price.toStringAsFixed(2)} EUR'),
        trailing: SizedBox(
          width: 120,
          child: Row(
            children: [
              IconButton(
                onPressed: () => cart.decrease(product),
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text(item.quantity.toString().padLeft(2, '0')),
              IconButton(
                onPressed: () => cart.add(product),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

