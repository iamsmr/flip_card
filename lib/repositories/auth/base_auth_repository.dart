import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Future<auth.User?> createAccountWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
  });
  Future<auth.User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<auth.User?> loginWithGoogleAccount();

  Future<void> logout();
}
