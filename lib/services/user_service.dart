import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>>
      get _users => _firestore.collection('users');

  // Get current user's profile
  Future<DocumentSnapshot<Map<String, dynamic>>>
      getUser(String uid) {
    return _users.doc(uid).get();
  }

  // Create user only if the profile does not already exist
  Future<void> createUserIfNeeded(User user) async {
    final userRef = _users.doc(user.uid);

    final snapshot = await userRef.get();

    // Existing website account:
    // DO NOT overwrite it.
    if (snapshot.exists) {
      return;
    }

    await userRef.set({
      'uid': user.uid,
      'displayName': user.displayName ?? '',
      'email': user.email ?? '',
      'phone': '',
      'nationality': '',
      'role': 'user',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Update profile from mobile app
  Future<void> updateProfile({
    required String uid,
    required String displayName,
    required String phone,
    required String nationality,
  }) async {
    await _users.doc(uid).update({
      'displayName': displayName.trim(),
      'phone': phone.trim(),
      'nationality': nationality.trim(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}