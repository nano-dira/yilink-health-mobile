import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  //============================================================
  // GOOGLE SIGN IN
  //============================================================

  Future<UserCredential?> signInWithGoogle() async {
    try {
      UserCredential userCredential;

      if (kIsWeb) {
        final GoogleAuthProvider provider = GoogleAuthProvider();

        provider.setCustomParameters({
          'prompt': 'select_account',
        });

        userCredential = await _auth.signInWithPopup(provider);
      } else {
        final GoogleSignIn googleSignIn = GoogleSignIn();

        // Always show account picker
        await googleSignIn.signOut();

        final GoogleSignInAccount? googleUser =
            await googleSignIn.signIn();

        if (googleUser == null) {
          // User cancelled login
          return null;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        userCredential =
            await _auth.signInWithCredential(credential);
      }

      final user = userCredential.user;

      if (user != null) {
        await _syncUserWithFirestore(user);
      }

      return userCredential;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      rethrow;
    }
  }

  //============================================================
  // FIRESTORE USER SYNC
  //============================================================

  Future<void> _syncUserWithFirestore(User user) async {
    final userRef =
        _firestore.collection('users').doc(user.uid);

    final snapshot = await userRef.get();

    if (!snapshot.exists) {
      await userRef.set({
        'uid': user.uid,
        'displayName': user.displayName ?? '',
        'email': user.email ?? '',
        'phone': '',
        'nationality': '',
        'role': 'user',
        'photoUrl': user.photoURL ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return;
    }

    await userRef.set({
      'displayName': user.displayName ?? '',
      'email': user.email ?? '',
      'photoUrl': user.photoURL ?? '',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  //============================================================
  // SIGN OUT
  //============================================================

  Future<void> signOut() async {
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }

    await _auth.signOut();
  }
}