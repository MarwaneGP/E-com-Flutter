import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/src/core/services/pwa_install_service.dart';
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
            ValueListenableBuilder<bool>(
              valueListenable: PwaInstallService.installAvailable,
              builder: (context, canInstall, _) {
                if (!canInstall) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: FilledButton.icon(
                    onPressed: () async {
                      final success = await PwaInstallService.promptInstall();
                      if (!success) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Installe manuellement via le menu du navigateur',
                            ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Installer la version web'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
