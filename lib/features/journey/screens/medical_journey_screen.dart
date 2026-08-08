import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../hospitals/screens/explore_hospitals_screen.dart';

class MedicalJourneyScreen extends StatelessWidget {
  const MedicalJourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // HEADER
              // =========================================================
              const Text(
                'Medical Journey',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 7),

              const Text(
                'Your healthcare journey in Malaysia, made simple.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 26),

              // =========================================================
              // HERO
              // =========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.route_rounded,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'We’re with you at\nevery step.',
                      style: TextStyle(
                        fontSize: 25,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      'From choosing the right hospital to treatment, '
                      'travel and recovery, YiLink helps coordinate '
                      'your healthcare journey.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.55,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 22),

                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ExploreHospitalsScreen(),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                      ),
                      icon: const Icon(Icons.search_rounded),
                      label: const Text(
                        'Find a Hospital',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              const Text(
                'Your Journey',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'A simple guide from enquiry to recovery.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 20),

              // =========================================================
              // JOURNEY STEPS
              // =========================================================
              const _JourneyStep(
                number: '01',
                icon: Icons.search_rounded,
                title: 'Explore Healthcare',
                description:
                    'Discover trusted Malaysian hospitals, specialists and treatment options.',
                first: true,
              ),

              const _JourneyStep(
                number: '02',
                icon: Icons.chat_bubble_outline_rounded,
                title: 'Request Consultation',
                description:
                    'Send your healthcare request and preferred hospital to the YiLink team.',
              ),

              const _JourneyStep(
                number: '03',
                icon: Icons.event_available_outlined,
                title: 'Plan Your Treatment',
                description:
                    'Coordinate your consultation date, hospital visit and treatment plan.',
              ),

              const _JourneyStep(
                number: '04',
                icon: Icons.flight_takeoff_rounded,
                title: 'Prepare Your Travel',
                description:
                    'Plan your journey to Malaysia including arrival, transport and accommodation.',
              ),

              const _JourneyStep(
                number: '05',
                icon: Icons.local_hospital_outlined,
                title: 'Receive Care',
                description:
                    'Attend your hospital consultation and receive treatment from your selected provider.',
              ),

              const _JourneyStep(
                number: '06',
                icon: Icons.favorite_outline_rounded,
                title: 'Recovery & Follow-up',
                description:
                    'Continue your recovery journey with follow-up care and support.',
                last: true,
              ),

              const SizedBox(height: 32),

              // =========================================================
              // TRAVEL ASSISTANCE
              // =========================================================
              const Text(
                'Travel Assistance',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 16),

              const Row(
                children: [
                  Expanded(
                    child: _ServiceCard(
                      icon: Icons.flight_land_rounded,
                      title: 'Airport',
                      subtitle: 'Arrival assistance',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ServiceCard(
                      icon: Icons.directions_car_outlined,
                      title: 'Transport',
                      subtitle: 'Hospital transfers',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Row(
                children: [
                  Expanded(
                    child: _ServiceCard(
                      icon: Icons.hotel_outlined,
                      title: 'Stay',
                      subtitle: 'Accommodation',
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _ServiceCard(
                      icon: Icons.translate_rounded,
                      title: 'Language',
                      subtitle: 'Patient support',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // =========================================================
              // SUPPORT
              // =========================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.support_agent_rounded,
                      color: AppColors.primary,
                      size: 32,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need help with your journey?',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Our team can help coordinate your healthcare visit in Malaysia.',
                            style: TextStyle(
                              fontSize: 11,
                              height: 1.5,
                              color: AppColors.textSecondary,
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
    );
  }
}

// ============================================================================
// JOURNEY STEP
// ============================================================================

class _JourneyStep extends StatelessWidget {
  final String number;
  final IconData icon;
  final String title;
  final String description;
  final bool first;
  final bool last;

  const _JourneyStep({
    required this.number,
    required this.icon,
    required this.title,
    required this.description,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 52,
            child: Column(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
                if (!last)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: last ? 0 : 24,
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STEP $number',
                      style: const TextStyle(
                        fontSize: 9,
                        letterSpacing: 1.3,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.55,
                        color: AppColors.textSecondary,
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
}

// ============================================================================
// SERVICE CARD
// ============================================================================

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 37,
            height: 37,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 19,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}