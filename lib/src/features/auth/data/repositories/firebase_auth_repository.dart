import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  AppUser? _toAppUser(User? user) {
    if (user == null) return null;
    final email = user.email;
    if (email == null) return null;
    return AppUser(id: user.uid, email: email);
  }

  @override
  Stream<AppUser?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map(_toAppUser);
  }

  @override
  Future<AppUser?> signIn(String email, String password) async {
    final cred = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _toAppUser(cred.user);
  }

  @override
  Future<AppUser?> register(String email, String password) async {
    final cred = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _toAppUser(cred.user);
  }

  @override
  Future<void> signOut() => _firebaseAuth.signOut();
}
