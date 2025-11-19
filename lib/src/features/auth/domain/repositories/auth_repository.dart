import '../entities/app_user.dart';

abstract class AuthRepository {
  Stream<AppUser?> authStateChanges();
  Future<AppUser?> signIn(String email, String password);
  Future<AppUser?> register(String email, String password);
  Future<void> signOut();
}
