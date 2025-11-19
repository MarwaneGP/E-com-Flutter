import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'src/core/routing/app_router.dart';
import 'src/features/auth/data/repositories/firebase_auth_repository.dart';
import 'src/features/auth/domain/repositories/auth_repository.dart';
import 'src/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'src/features/cart/data/repositories/local_orders_repository.dart';
import 'src/features/cart/domain/repositories/orders_repository.dart';
import 'src/features/cart/presentation/viewmodels/cart_view_model.dart';
import 'src/features/cart/presentation/viewmodels/orders_view_model.dart';
import 'src/features/catalog/data/repositories/local_catalog_repository.dart';
import 'src/features/catalog/domain/repositories/catalog_repository.dart';
import 'src/features/catalog/presentation/viewmodels/catalog_view_model.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  await LocalOrdersRepository.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(create: (_) => FirebaseAuthRepository()),
        ChangeNotifierProvider<AuthViewModel>(
          create: (context) => AuthViewModel(context.read<AuthRepository>()),
        ),
        Provider<CatalogRepository>(create: (_) => LocalCatalogRepository()),
        ChangeNotifierProvider<CatalogViewModel>(
          create: (context) =>
              CatalogViewModel(context.read<CatalogRepository>()),
        ),
        Provider<OrdersRepository>(create: (_) => LocalOrdersRepository()),
        ChangeNotifierProvider<CartViewModel>(
          create: (context) =>
              CartViewModel(context.read<OrdersRepository>()),
        ),
        ChangeNotifierProvider<OrdersViewModel>(
          create: (context) =>
              OrdersViewModel(context.read<OrdersRepository>()),
        ),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, auth, _) {
          final router = createRouter(auth);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'ShopFlutter',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
              useMaterial3: true,
            ),
            routerConfig: router,
          );
        },
      ),
    );
  }
}

