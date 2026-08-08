import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/hospital.dart';
import '../../booking/screens/booking_screen.dart';
import '../widgets/package_card.dart';

class HospitalDetailsScreen extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailsScreen({
    super.key,
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // ============================================================
      // STICKY BOOKING BUTTON
      // ============================================================

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            20,
            12,
            20,
            16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: AppColors.border,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.05,
                ),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingScreen(
                    hospital: hospital,
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(
                double.infinity,
                56,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                SizedBox(width: 9),
                Text(
                  'Request Consultation',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),

      // ============================================================
      // PAGE
      // ============================================================

      body: CustomScrollView(
        slivers: [
          // ==========================================================
          // HERO IMAGE
          // ==========================================================

          SliverToBoxAdapter(
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 330,
                  child: hospital.imageUrl.isNotEmpty
                      ? Image.network(
                          hospital.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const _HeroFallback();
                          },
                        )
                      : const _HeroFallback(),
                ),

                // Gradient overlay
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [
                          0,
                          0.55,
                          1,
                        ],
                        colors: [
                          Colors.black26,
                          Colors.transparent,
                          Colors.black54,
                        ],
                      ),
                    ),
                  ),
                ),

                // Back button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: _FloatingButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),

                // Partner badge
                Positioned(
                  left: 20,
                  bottom: 86,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.94,
                      ),
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'YiLink Healthcare Partner',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Hospital name
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 20,
                  child: Text(
                    hospital.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 25,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================================
          // CONTENT
          // ==========================================================

          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -1),
              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  24,
                  20,
                  40,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==================================================
                    // LOCATION
                    // ==================================================

                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius:
                                BorderRadius.circular(13),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            size: 21,
                            color: AppColors.primary,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 10,
                                  color:
                                      AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                _locationText(hospital),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ==================================================
                    // QUICK INFORMATION
                    // ==================================================

                    Row(
                      children: [
                        Expanded(
                          child: _InfoCard(
                            icon: Icons
                                .medical_services_outlined,
                            value:
                                '${hospital.specialties.length}',
                            label: 'Specialties',
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: _InfoCard(
                            icon: Icons
                                .health_and_safety_outlined,
                            value: hospital.packages.isEmpty
                                ? 'Care'
                                : '${hospital.packages.length}',
                            label: hospital.packages.isEmpty
                                ? 'Services'
                                : 'Packages',
                          ),
                        ),

                        const SizedBox(width: 10),

                        const Expanded(
                          child: _InfoCard(
                            icon: Icons
                                .support_agent_rounded,
                            value: 'YiLink',
                            label: 'Assistance',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 34),

                    // ==================================================
                    // ABOUT
                    // ==================================================

                    const _SectionHeader(
                      icon: Icons.info_outline_rounded,
                      title: 'About the Hospital',
                    ),

                    const SizedBox(height: 14),

                    Text(
                      _description(hospital),
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.65,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    // ==================================================
                    // SPECIALTIES
                    // ==================================================

                    if (hospital.specialties.isNotEmpty) ...[
                      const SizedBox(height: 36),

                      const _SectionHeader(
                        icon: Icons
                            .medical_services_outlined,
                        title: 'Medical Specialties',
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        'Healthcare services available at this hospital.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 9,
                        runSpacing: 9,
                        children: hospital.specialties
                            .map(
                              (specialty) =>
                                  _SpecialtyChip(
                                specialty: specialty,
                              ),
                            )
                            .toList(),
                      ),
                    ],

                    // ==================================================
                    // PACKAGES
                    // ==================================================

                    if (hospital.packages.isNotEmpty) ...[
                      const SizedBox(height: 36),

                      const _SectionHeader(
                        icon:
                            Icons.inventory_2_outlined,
                        title: 'Treatment Packages',
                      ),

                      const SizedBox(height: 7),

                      const Text(
                        'Explore available healthcare and treatment packages.',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      const SizedBox(height: 16),

                      ...hospital.packages.map(
                        (package) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: PackageCard(
                            title: package.title,
                            price: package.price,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BookingScreen(
                                    hospital: hospital,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 34),

                    // ==================================================
                    // MEDICAL TOURISM ASSISTANCE
                    // ==================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                            BorderRadius.circular(22),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -25,
                            bottom: -35,
                            child: Icon(
                              Icons.flight_takeoff_rounded,
                              size: 120,
                              color: Colors.white.withValues(
                                alpha: 0.07,
                              ),
                            ),
                          ),

                          const Row(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              _TourismIcon(),

                              SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Travelling for treatment?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),

                                    SizedBox(height: 7),

                                    Text(
                                      'YiLink can help coordinate your hospital consultation and medical journey in Malaysia.',
                                      style: TextStyle(
                                        fontSize: 11,
                                        height: 1.5,
                                        color:
                                            Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ==================================================
                    // DISCLAIMER
                    // ==================================================

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.border,
                        ),
                      ),
                      child: const Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons
                                .health_and_safety_outlined,
                            size: 19,
                            color: AppColors.primary,
                          ),

                          SizedBox(width: 11),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Healthcare assistance',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight:
                                        FontWeight.w700,
                                    color: AppColors
                                        .textPrimary,
                                  ),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  'YiLink helps connect patients with healthcare providers. Final treatment recommendations and medical decisions are made by the healthcare provider.',
                                  style: TextStyle(
                                    fontSize: 10,
                                    height: 1.5,
                                    color: AppColors
                                        .textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // HELPERS
  // ================================================================

  String _locationText(Hospital hospital) {
    if (hospital.city.isNotEmpty &&
        hospital.state.isNotEmpty &&
        hospital.city != hospital.state) {
      return '${hospital.city}, ${hospital.state}';
    }

    if (hospital.city.isNotEmpty) {
      return hospital.city;
    }

    if (hospital.state.isNotEmpty) {
      return hospital.state;
    }

    return 'Malaysia';
  }

  String _description(Hospital hospital) {
    if (hospital.description.trim().isNotEmpty) {
      return hospital.description.trim();
    }

    if (hospital.blurb.trim().isNotEmpty) {
      return hospital.blurb.trim();
    }

    return '${hospital.name} is one of the healthcare providers available through YiLink Health. Explore available specialties and request a consultation through YiLink.';
  }
}

// ============================================================================
// SECTION HEADER
// ============================================================================

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// QUICK INFO CARD
// ============================================================================

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 21,
            color: AppColors.primary,
          ),

          const SizedBox(height: 7),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 2),

          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SPECIALTY
// ============================================================================

class _SpecialtyChip extends StatelessWidget {
  final String specialty;

  const _SpecialtyChip({
    required this.specialty,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_rounded,
              size: 14,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 7),

          Text(
            specialty,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// PACKAGE CARD
// ============================================================================

// class _PackageCard extends StatelessWidget {
//   final String title;
//   final num price;
//   final VoidCallback onTap;

//   const _PackageCard({
//     super.key,
//     required this.title,
//     required this.price,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(18),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(18),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.all(17),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: AppColors.border,
//             ),
//           ),
//           child: Row(
//             children: [
//               Container(
//                 width: 46,
//                 height: 46,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryLight,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: const Icon(
//                   Icons.medical_services_outlined,
//                   size: 22,
//                   color: AppColors.primary,
//                 ),
//               ),

//               const SizedBox(width: 14),

//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: AppColors.textPrimary,
//                       ),
//                     ),

//                     if (price > 0) ...[
//                       const SizedBox(height: 6),

//                       Text(
//                         "From RM ${price.toStringAsFixed(0)}",
//                         style: const TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],

//                     const SizedBox(height: 8),

//                     const Text(
//                       "Tap to request consultation",
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: AppColors.textSecondary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 size: 16,
//                 color: AppColors.textSecondary,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ============================================================================
// FLOATING BUTTON
// ============================================================================

class _FloatingButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _FloatingButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(
        alpha: 0.94,
      ),
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Icon(
            icon,
            size: 21,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// MEDICAL TOURISM ICON
// ============================================================================

class _TourismIcon extends StatelessWidget {
  const _TourismIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white.withValues(
          alpha: 0.15,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.flight_takeoff_rounded,
        color: Colors.white,
        size: 22,
      ),
    );
  }
}

// ============================================================================
// HERO FALLBACK
// ============================================================================

class _HeroFallback extends StatelessWidget {
  const _HeroFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLight,
      child: const Center(
        child: Icon(
          Icons.local_hospital_rounded,
          size: 75,
          color: AppColors.primary,
        ),
      ),
    );
  }
}