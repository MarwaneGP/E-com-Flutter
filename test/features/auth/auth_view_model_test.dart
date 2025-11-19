import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_1/src/features/auth/domain/entities/app_user.dart';
import 'package:flutter_application_1/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/src/features/auth/presentation/viewmodels/auth_view_model.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;
  late AuthViewModel viewModel;

  setUp(() {
    repository = MockAuthRepository();
    when(() => repository.authStateChanges()).thenAnswer((_) => Stream.value(null));
    viewModel = AuthViewModel(repository);
  });

  test('login clears error on success', () async {
    when(() => repository.signIn('user@test.com', 'pass'))
        .thenAnswer((_) async => const AppUser(id: '1', email: 'user@test.com'));

    await viewModel.login('user@test.com', 'pass');

    expect(viewModel.error, isNull);
    expect(viewModel.isLoading, isFalse);
  });

  test('login exposes error on failure', () async {
    when(() => repository.signIn(any(), any()))
        .thenThrow(Exception('invalid credentials'));

    await viewModel.login('user@test.com', 'wrong');

    expect(viewModel.error, contains('invalid credentials'));
    expect(viewModel.isLoading, isFalse);
  });
}
