import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/src/features/auth/domain/entities/app_user.dart';
import 'package:flutter_application_1/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/src/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_application_1/src/features/auth/presentation/viewmodels/auth_view_model.dart';

class FakeAuthRepository implements AuthRepository {
  bool signInCalled = false;

  @override
  Stream<AppUser?> authStateChanges() => const Stream.empty();

  @override
  Future<AppUser?> register(String email, String password) async => null;

  @override
  Future<AppUser?> signIn(String email, String password) async {
    signInCalled = true;
    return null;
  }

  @override
  Future<void> signOut() async {}
}

void main() {
  testWidgets('LoginPage displays fields and triggers login', (tester) async {
    final repository = FakeAuthRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => AuthViewModel(repository),
          child: const LoginPage(),
        ),
      ),
    );

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Se connecter'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'user@test.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    await tester.tap(find.text('Se connecter'));
    await tester.pump();

    expect(repository.signInCalled, isTrue);
  });
}
