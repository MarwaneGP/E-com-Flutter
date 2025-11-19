import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/src/core/widgets/shop_scaffold.dart';
import '../viewmodels/cart_view_model.dart';
import '../viewmodels/orders_view_model.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _success = false;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartViewModel>();

    return ShopScaffold(
      title: 'Checkout',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Total commande'),
                subtitle: Text('${cart.total.toStringAsFixed(2)} EUR'),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: cart.items
                    .map(
                      (item) => ListTile(
                        title: Text(item.product.title),
                        subtitle: Text('x${item.quantity}'),
                        trailing: Text('${item.subtotal.toStringAsFixed(2)} EUR'),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: cart.isCheckoutInProgress
                  ? null
                  : () async {
                      final order = await cart.checkout();
                      if (order != null && mounted) {
                        await context.read<OrdersViewModel>().loadOrders();
                        setState(() => _success = true);
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Commande creee avec succes'),
                            ),
                          );
                          context.go('/orders');
                        }
                      }
                    },
              icon: cart.isCheckoutInProgress
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.payment),
              label: Text(_success ? 'Commande passee' : 'Payer'),
            ),
          ],
        ),
      ),
    );
  }
}

