import '../models/hospital.dart';

class MockHospitalService {
  static const List<Hospital> hospitals = [
    // ALTY Orthopaedic Hospital
    Hospital(
      id: 'alty',
      name: 'ALTY Orthopaedic Hospital',
      city: 'Kuala Lumpur',
      state: 'Kuala Lumpur',
      description:
          'A specialist orthopaedic hospital providing comprehensive care '
          'for bone, joint, spine, and musculoskeletal conditions.',
      specialties: [
        'Orthopaedics',
        'Spine',
        'Sports Medicine',
        'Joint Replacement',
      ],
      languages: [
        'English',
        'Malay',
        'Mandarin',
        'Tamil',
      ],
      rating: 4.8,
      imageUrl: '',
      packages: [
        TreatmentPackage(
          title: 'Knee Replacement Package',
          price: 35000,
        ),
        TreatmentPackage(
          title: 'Hip Replacement Package',
          price: 38000,
        ),
      ],
    ),

    // Prince Court Medical Centre
    Hospital(
      id: 'prince-court',
      name: 'Prince Court Medical Centre',
      city: 'Kuala Lumpur',
      state: 'Kuala Lumpur',
      description:
          'A private medical centre offering multidisciplinary healthcare '
          'services for local and international patients.',
      specialties: [
        'Cardiology',
        'Oncology',
        'Orthopaedics',
        'Women\'s Health',
      ],
      languages: [
        'English',
        'Malay',
        'Mandarin',
      ],
      rating: 4.9,
      imageUrl: '',
      packages: [
        TreatmentPackage(
          title: 'Health Screening Package',
          price: 1200,
        ),
        TreatmentPackage(
          title: 'Cardiac Screening',
          price: 1800,
        ),
      ],
    ),

    // Alpha IVF
    Hospital(
      id: 'alpha-ivf',
      name: 'Alpha IVF & Women\'s Specialists',
      city: 'Petaling Jaya',
      state: 'Selangor',
      description:
          'A fertility and women\'s health centre specialising in '
          'reproductive medicine and assisted reproductive treatments.',
      specialties: [
        'Fertility',
        'IVF',
        'Women\'s Health',
      ],
      languages: [
        'English',
        'Malay',
        'Mandarin',
      ],
      rating: 4.8,
      imageUrl: '',
      packages: [
        TreatmentPackage(
          title: 'IVF Consultation',
          price: 350,
        ),
        TreatmentPackage(
          title: 'Fertility Assessment',
          price: 650,
        ),
      ],
    ),
  ];
}