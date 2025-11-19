import '../../features/auth/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/viewmodels/auth_view_model.dart';
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/cart/presentation/pages/checkout_page.dart';
import '../../features/cart/presentation/pages/orders_page.dart';
import '../../features/catalog/presentation/pages/catalog_page.dart';
import '../../features/catalog/presentation/pages/product_detail_page.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter(AuthViewModel auth) {
  return GoRouter(
    initialLocation: '/catalog',
    refreshListenable: auth,
    redirect: (context, state) {
      final loggedIn = auth.isLoggedIn;
      final loggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!loggedIn && !loggingIn) {
        return '/login';
      }

      if (loggedIn && loggingIn) {
        return '/catalog';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      GoRoute(path: '/home', builder: (_, __) => const HomePage()),
      GoRoute(path: '/catalog', builder: (_, __) => const CatalogPage()),
      GoRoute(
        path: '/product/:id',
        builder: (_, state) =>
            ProductDetailPage(productId: state.pathParameters['id']!),
      ),
      GoRoute(path: '/cart', builder: (_, __) => const CartPage()),
      GoRoute(path: '/checkout', builder: (_, __) => const CheckoutPage()),
      GoRoute(path: '/orders', builder: (_, __) => const OrdersPage()),
    ],
  );
}

