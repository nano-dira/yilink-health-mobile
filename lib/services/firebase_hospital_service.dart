import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/hospital.dart';

class FirebaseHospitalService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  Stream<List<Hospital>> getHospitals() {
    return _firestore
        .collection('hospitals')
        .snapshots()
        .map<List<Hospital>>(
          (snapshot) {
            return snapshot.docs
                .map<Hospital>(
                  (document) =>
                      Hospital.fromFirestore(document),
                )
                .toList();
          },
        );
  }

  Future<Hospital?> getHospitalById(
    String id,
  ) async {
    final document = await _firestore
        .collection('hospitals')
        .doc(id)
        .get();

    if (!document.exists) {
      return null;
    }

    return Hospital.fromFirestore(document);
  }
}