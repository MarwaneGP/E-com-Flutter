import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShopScaffold extends StatelessWidget {
  const ShopScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  void _navigate(BuildContext context, String route) {
    Navigator.of(context).pop();
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () => context.go('/home'),
        ),
        title: Text(title),
        actions: [
          ...?actions,
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.black12),
                child: Text('Navigation'),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Accueil'),
                onTap: () => _navigate(context, '/home'),
              ),
              ListTile(
                leading: const Icon(Icons.storefront_outlined),
                title: const Text('Catalogue'),
                onTap: () => _navigate(context, '/catalog'),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart_outlined),
                title: const Text('Panier'),
                onTap: () => _navigate(context, '/cart'),
              ),
              ListTile(
                leading: const Icon(Icons.payment_outlined),
                title: const Text('Checkout'),
                onTap: () => _navigate(context, '/checkout'),
              ),
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: const Text('Commandes'),
                onTap: () => _navigate(context, '/orders'),
              ),
            ],
          ),
        ),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

