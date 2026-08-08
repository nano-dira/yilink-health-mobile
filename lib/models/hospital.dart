import 'package:cloud_firestore/cloud_firestore.dart';

class TreatmentPackage {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  const TreatmentPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory TreatmentPackage.fromMap(Map<String, dynamic> map) {
    final rawPrice = map['price'];

    double price = 0;

    if (rawPrice is num) {
      price = rawPrice.toDouble();
    } else if (rawPrice is String) {
      price = double.tryParse(
            rawPrice
                .replaceAll("RM", "")
                .replaceAll(",", "")
                .trim(),
          ) ??
          0;
    }

    return TreatmentPackage(
      id: (map['id'] ?? '').toString(),
      title: (map['title'] ?? map['name'] ?? '').toString(),
      description: (map['description'] ?? '').toString(),
      imageUrl: (map['image'] ?? '').toString(),
      price: price,
    );
  }
}

class Hospital {
  final String id;
  final String name;
  final String city;
  final String state;
  final String description;
  final String blurb;
  final List<String> specialties;
  final List<String> languages;
  final double rating;
  final String imageUrl;
  final List<TreatmentPackage> packages;

  const Hospital({
    required this.id,
    required this.name,
    required this.city,
    required this.state,
    required this.description,
    required this.blurb,
    required this.specialties,
    required this.languages,
    required this.rating,
    required this.imageUrl,
    required this.packages,
  });

  factory Hospital.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? {};

    return Hospital(
      id: document.id,

      name: (data['name'] ?? '').toString(),

      city: (data['city'] ?? '').toString(),

      state: (data['state'] ?? '').toString(),

      description: (data['description'] ?? '').toString(),

      blurb: (data['blurb'] ?? '').toString(),

      specialties: _parseStringList(
        data['specialties'],
      ),

      languages: _parseStringList(
        data['languages'],
      ),

      rating: _parseDouble(
        data['rating'],
      ),

      // Firestore field is called "img"
      imageUrl: (data['img'] ?? '').toString(),

      packages: _parsePackages(
        data['packages'],
      ),
    );
  }

  static List<String> _parseStringList(dynamic value) {
    if (value is List) {
      return value
          .map((item) => item.toString())
          .toList();
    }

    return [];
  }

  static double _parseDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }

    if (value is num) {
      return value.toDouble();
    }

    if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }

    return 0.0;
  }

  static List<TreatmentPackage> _parsePackages(
    dynamic value,
  ) {
    if (value is! List) {
      return [];
    }

    return value
        .whereType<Map>()
        .map(
          (item) => TreatmentPackage.fromMap(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }
}