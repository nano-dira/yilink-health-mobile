import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  final String id;
  final String bookingNo;

  // User
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String nationality;

  // Hospital
  final String hospitalId;
  final String hospitalName;
  final String hospitalPackage;
  final String treatment;

  // Consultation
  final String preferredDate;
  final String notes;

  // Status
  final String status;
  final bool patientVisible;

  // Coordinator
  final String coordinatorName;
  final String coordinatorPhone;
  final String coordinatorEmail;

  // Appointment
  final String doctorName;
  final String appointmentDate;
  final String appointmentTime;
  final String meetingLink;
  final String estimatedContactDate;

  // Admin
  final String adminNotes;

  // Source
  final String source;

  // Timestamp
  final DateTime createdAt;
  final DateTime updatedAt;

  const Booking({
    required this.id,
    required this.bookingNo,

    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.nationality,

    required this.hospitalId,
    required this.hospitalName,
    required this.hospitalPackage,
    required this.treatment,

    required this.preferredDate,
    required this.notes,

    required this.status,
    required this.patientVisible,

    required this.coordinatorName,
    required this.coordinatorPhone,
    required this.coordinatorEmail,

    required this.doctorName,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.meetingLink,
    required this.estimatedContactDate,

    required this.adminNotes,

    required this.source,

    required this.createdAt,
    required this.updatedAt,
  });

  factory Booking.fromFirestore(Map<String, dynamic> json) {
    DateTime parseTimestamp(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      }

      if (value is DateTime) {
        return value;
      }

      return DateTime.now();
    }

    return Booking(
      id: json['id'] ?? '',
      bookingNo: json['bookingNo'] ?? '',

      uid: json['uid'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      nationality: json['nationality'] ?? '',

      hospitalId: json['hospitalId'] ?? '',
      hospitalName: json['hospitalName'] ?? '',
      hospitalPackage: json['hospitalPackage'] ?? '',
      treatment: json['treatment'] ?? '',

      preferredDate: json['preferredDate'] ?? '',
      notes: json['notes'] ?? '',

      status: json['status'] ?? 'Pending Review',
      patientVisible: json['patientVisible'] ?? true,

      coordinatorName: json['coordinatorName'] ?? '',
      coordinatorPhone: json['coordinatorPhone'] ?? '',
      coordinatorEmail: json['coordinatorEmail'] ?? '',

      doctorName: json['doctorName'] ?? '',
      appointmentDate: json['appointmentDate'] ?? '',
      appointmentTime: json['appointmentTime'] ?? '',
      meetingLink: json['meetingLink'] ?? '',
      estimatedContactDate: json['estimatedContactDate'] ?? '',

      adminNotes: json['adminNotes'] ?? '',

      source: json['source'] ?? 'Mobile App',

      createdAt: parseTimestamp(json['createdAt']),
      updatedAt: parseTimestamp(json['updatedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'bookingNo': bookingNo,

      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'nationality': nationality,

      'hospitalId': hospitalId,
      'hospitalName': hospitalName,
      'hospitalPackage': hospitalPackage,
      'treatment': treatment,

      'preferredDate': preferredDate,
      'notes': notes,

      'status': status,
      'patientVisible': patientVisible,

      'coordinatorName': coordinatorName,
      'coordinatorPhone': coordinatorPhone,
      'coordinatorEmail': coordinatorEmail,

      'doctorName': doctorName,
      'appointmentDate': appointmentDate,
      'appointmentTime': appointmentTime,
      'meetingLink': meetingLink,
      'estimatedContactDate': estimatedContactDate,

      'adminNotes': adminNotes,

      'source': source,

      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  Booking copyWith({
    String? id,
    String? bookingNo,
    String? uid,
    String? fullName,
    String? email,
    String? phone,
    String? nationality,
    String? hospitalId,
    String? hospitalName,
    String? hospitalPackage,
    String? treatment,
    String? preferredDate,
    String? notes,
    String? status,
    bool? patientVisible,
    String? coordinatorName,
    String? coordinatorPhone,
    String? coordinatorEmail,
    String? doctorName,
    String? appointmentDate,
    String? appointmentTime,
    String? meetingLink,
    String? estimatedContactDate,
    String? adminNotes,
    String? source,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      bookingNo: bookingNo ?? this.bookingNo,

      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      nationality: nationality ?? this.nationality,

      hospitalId: hospitalId ?? this.hospitalId,
      hospitalName: hospitalName ?? this.hospitalName,
      hospitalPackage: hospitalPackage ?? this.hospitalPackage,
      treatment: treatment ?? this.treatment,

      preferredDate: preferredDate ?? this.preferredDate,
      notes: notes ?? this.notes,

      status: status ?? this.status,
      patientVisible: patientVisible ?? this.patientVisible,

      coordinatorName: coordinatorName ?? this.coordinatorName,
      coordinatorPhone: coordinatorPhone ?? this.coordinatorPhone,
      coordinatorEmail: coordinatorEmail ?? this.coordinatorEmail,

      doctorName: doctorName ?? this.doctorName,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      meetingLink: meetingLink ?? this.meetingLink,
      estimatedContactDate:
          estimatedContactDate ?? this.estimatedContactDate,

      adminNotes: adminNotes ?? this.adminNotes,

      source: source ?? this.source,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}