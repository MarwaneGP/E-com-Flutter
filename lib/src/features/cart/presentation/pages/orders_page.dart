import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/src/core/widgets/shop_scaffold.dart';
import '../../domain/entities/order.dart';
import '../viewmodels/orders_view_model.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OrdersViewModel>().loadOrders());
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OrdersViewModel>();
    final orders = vm.orders;

    return ShopScaffold(
      title: 'Mes commandes',
      body: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? const Center(child: Text('Aucune commande pour le moment'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  itemBuilder: (_, index) {
                    final order = orders[index];
                    return _OrderCard(order: order);
                  },
                ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Commande #${order.id}',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Cree le ${order.createdAt.toLocal().toString().split('.').first}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ...order.items.map((item) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(item.product.title),
                  subtitle: Text('x${item.quantity}'),
                  trailing: Text('${item.subtotal.toStringAsFixed(2)} EUR'),
                )),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${order.total.toStringAsFixed(2)} EUR',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

