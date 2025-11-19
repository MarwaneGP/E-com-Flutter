import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/src/core/widgets/shop_scaffold.dart';
import '../viewmodels/auth_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthViewModel>();
    final email = auth.user?.email ?? 'Utilisateur';

    return ShopScaffold(
      title: 'Home',
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => auth.logout(),
        ),
      ],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bonjour $email'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/catalog'),
              child: const Text('Voir le catalogue'),
            ),
          ],
        ),
      ),
    );
  }
}

