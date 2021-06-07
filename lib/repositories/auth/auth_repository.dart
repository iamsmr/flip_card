import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flash_card/config/paths.dart';
import 'package:flash_card/models/models.dart';
import 'package:flash_card/repositories/repositories.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn _googleSignIn;

  /// Initilization of [firebase AUth] [firebase firestore] and [google sign in]
  AuthRepository({
    auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
    GoogleSignIn? googleSignIn,
  })  : _googleSignIn = googleSignIn ?? GoogleSignIn(),
        _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  /// Override Create [Firebase Account] Method From Base [Auth Repository]
  @override
  Future<auth.User?> createAccountWithEmailAndPassword({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      await _firebaseFirestore.collection(Paths.users).doc(user?.uid).set({
        "displayName": fullName,
        "email": email,
        "photoURL": user?.photoURL,
      });
      return user;
    } on auth.FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? "");
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? "");
    }
  }

  /// Override login [Firebase Account] Method From Base [Auth Repository]
  ///

  @override
  Future<auth.User?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credentinal = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credentinal.user;
    } on auth.FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? "");
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? "");
    }
  }

  /// Override login with google [Firebase Account] Method From Base [Auth Repository]

  @override
  Future<auth.User?> loginWithGoogleAccount() async {
    try {
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication signInAuthentication =
          await signInAccount!.authentication;
      auth.AuthCredential credential = auth.GoogleAuthProvider.credential(
          accessToken: signInAuthentication.accessToken,
          idToken: signInAuthentication.idToken);

      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final user = authResult.user;

      final userDoc =
          await _firebaseFirestore.collection(Paths.users).doc(user?.uid).get();

      if (userDoc.exists) {
        await _firebaseFirestore.collection(Paths.users).doc(user?.uid).update({
          "email": user?.email,
        });
      } else {
        await _firebaseFirestore.collection(Paths.users).doc(user?.uid).update({
          "displayName": user?.displayName,
          "email": user?.email,
          "photoURL": user?.photoURL,
        });
      }

      return user;
    } on auth.FirebaseAuthException catch (e) {
      throw Failure(code: e.code, message: e.message ?? "");
    } on PlatformException catch (e) {
      throw Failure(code: e.code, message: e.message ?? "");
    }
  }

  /// Override logout [Firebase Account] Method From `Base` [Auth Repository]

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  /// Override notifier on  [User Changer] Method From `Base` [Auth Repository]

  @override
  Stream<auth.User?> get userChanged => _firebaseAuth.userChanges();
}
