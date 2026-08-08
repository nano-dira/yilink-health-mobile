import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges =>
      _auth.authStateChanges();

  Future<UserCredential> signInWithGoogle() async {
    final googleProvider = GoogleAuthProvider();

    googleProvider.addScope('email');
    googleProvider.addScope('profile');

    if (kIsWeb) {
      return await _auth.signInWithPopup(
        googleProvider,
      );
    }

    return await _auth.signInWithProvider(
      googleProvider,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}