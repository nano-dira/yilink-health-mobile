import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/booking.dart';

class BookingService {
  BookingService._();

  static final BookingService instance = BookingService._();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _bookingCollection =>
      _firestore.collection('bookings');

  //==========================================================
  // Generate Booking Number
  // Example:
  // YLH-20260801-6202
  //==========================================================

  String generateBookingNumber() {
    final now = DateTime.now();

    final date =
        "${now.year}"
        "${now.month.toString().padLeft(2, '0')}"
        "${now.day.toString().padLeft(2, '0')}";

    final random =
        (1000 + (DateTime.now().microsecond % 9000));

    return "YLH-$date-$random";
  }

  //==========================================================
  // Create Booking
  //==========================================================

  Future<String> createBooking({
    required String fullName,
    required String email,
    required String phone,
    required String nationality,
    required String hospitalId,
    required String hospitalName,
    required String hospitalPackage,
    required String treatment,
    required DateTime? preferredDate,
    required String notes,
    String source = "Mobile App",
  }) async {
    final bookingNo = generateBookingNumber();

    final uid = _auth.currentUser?.uid ?? "";

    final doc = _bookingCollection.doc();

    final now = Timestamp.now();

    await doc.set({
      "id": doc.id,
      "bookingNo": bookingNo,

      "uid": uid,

      "fullName": fullName,
      "email": email,
      "phone": phone,
      "nationality": nationality,

      "hospitalId": hospitalId,
      "hospitalName": hospitalName,
      "hospitalPackage": hospitalPackage,

      "treatment": treatment,

      "preferredDate": preferredDate == null
          ? ""
          : "${preferredDate.year}-${preferredDate.month.toString().padLeft(2, '0')}-${preferredDate.day.toString().padLeft(2, '0')}",

      "notes": notes,

      //---------------------------------
      // Patient
      //---------------------------------

      "patientVisible": true,

      //---------------------------------
      // Status
      //---------------------------------

      "status": "Pending Review",

      //---------------------------------
      // Coordinator
      //---------------------------------

      "coordinatorName": "",
      "coordinatorPhone": "",
      "coordinatorEmail": "",

      //---------------------------------
      // Hospital
      //---------------------------------

      "doctorName": "",
      "appointmentDate": "",
      "appointmentTime": "",
      "meetingLink": "",
      "estimatedContactDate": "",

      //---------------------------------
      // Admin
      //---------------------------------

      "adminNotes": "",

      //---------------------------------
      // Source
      //---------------------------------

      "source": source,

      //---------------------------------
      // Timestamp
      //---------------------------------

      "createdAt": now,
      "updatedAt": now,
    });

    return bookingNo;
  }

  //==========================================================
  // Get Current User Bookings
  //==========================================================

  Stream<List<Booking>> getCurrentUserBookings() {
    final uid = _auth.currentUser?.uid;

    if (uid == null) {
      return const Stream.empty();
    }

    return _bookingCollection
        .where("uid", isEqualTo: uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Booking.fromFirestore(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  //==========================================================
  // Get Booking
  //==========================================================

  Future<Booking?> getBooking(String id) async {
    final doc = await _bookingCollection.doc(id).get();

    if (!doc.exists) {
      return null;
    }

    return Booking.fromFirestore(
      doc.data() as Map<String, dynamic>,
    );
  }

  //==========================================================
  // Cancel Booking
  //==========================================================

  Future<void> cancelBooking(String bookingId) async {
    await _bookingCollection.doc(bookingId).update({
      "status": "Cancelled",
      "updatedAt": Timestamp.now(),
    });
  }

  //==========================================================
  // Update Booking
  //==========================================================

  Future<void> updateBooking({
    required String bookingId,
    required Map<String, dynamic> data,
  }) async {
    data["updatedAt"] = Timestamp.now();

    await _bookingCollection.doc(bookingId).update(data);
  }
}