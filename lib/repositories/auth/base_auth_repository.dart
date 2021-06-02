import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  /// It nottify whenever there is [change] in the `user`
  ///
  ///
  Stream<auth.User?> get userChanged;

  /// Base [Model] From creatting `user` with [email] and [passowrd]
  ///
  ///
  Future<auth.User?> createAccountWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
  });

  /// Base [model] form login with [email] and [password]

  Future<auth.User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<auth.User?> loginWithGoogleAccount();

  Future<void> logout();
}
