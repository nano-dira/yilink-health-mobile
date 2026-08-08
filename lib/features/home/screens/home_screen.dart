import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/hospital.dart';
import '../../../services/firebase_hospital_service.dart';
import '../../hospitals/screens/explore_hospitals_screen.dart';
import '../../hospitals/screens/hospital_details_screen.dart';
import '../../my_bookings/screens/my_bookings_screen.dart';

// ============================================================================
// HOME SCREEN
// ============================================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // HEADER
              // ============================================================
              _HomeHeader(
                onBookingsPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyBookingsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // ============================================================
              // INTRO
              // ============================================================
              const Text(
                'Your health journey\nstarts here.',
                style: TextStyle(
                  fontSize: 32,
                  height: 1.08,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.8,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Discover trusted hospitals, specialists and healthcare '
                'services across Malaysia.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 24),

              // ============================================================
              // SEARCH
              // ============================================================
              _SearchBar(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExploreHospitalsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 22),

              // ============================================================
              // HERO
              // ============================================================
              _HeroBanner(
                onExplorePressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExploreHospitalsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // ============================================================
              // JOURNEY QUICK ACTIONS
              // ============================================================
              const _SectionTitle(
                title: 'Your Healthcare Journey',
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.local_hospital_outlined,
                      title: 'Hospitals',
                      subtitle: 'Find care',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const ExploreHospitalsScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.calendar_month_outlined,
                      title: 'Bookings',
                      subtitle: 'View status',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                const MyBookingsScreen(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.flight_takeoff_rounded,
                      title: 'Travel',
                      subtitle: 'Plan journey',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Medical Journey is coming next.',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 34),

              // ============================================================
              // SPECIALTIES
              // ============================================================
              _SectionTitle(
                title: 'Popular Specialties',
                actionText: 'See all',
                onActionPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExploreHospitalsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    _SpecialtyChip(
                      icon: Icons.accessibility_new_rounded,
                      label: 'Orthopaedics',
                    ),
                    SizedBox(width: 8),
                    _SpecialtyChip(
                      icon: Icons.favorite_border_rounded,
                      label: 'Cardiology',
                    ),
                    SizedBox(width: 8),
                    _SpecialtyChip(
                      icon: Icons.child_care_rounded,
                      label: 'Fertility',
                    ),
                    SizedBox(width: 8),
                    _SpecialtyChip(
                      icon: Icons.health_and_safety_outlined,
                      label: 'Oncology',
                    ),
                    SizedBox(width: 8),
                    _SpecialtyChip(
                      icon: Icons.visibility_outlined,
                      label: 'Eye Care',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 34),

              // ============================================================
              // FEATURED HOSPITALS
              // ============================================================
              _SectionTitle(
                title: 'Featured Hospitals',
                actionText: 'View all',
                onActionPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ExploreHospitalsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 14),

              _FeaturedHospitals(),

              const SizedBox(height: 36),

              // ============================================================
              // MEDICAL TOURISM
              // ============================================================
              const _SectionTitle(
                title: 'Medical Tourism',
              ),

              const SizedBox(height: 14),

              const _MedicalTourismCard(),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HEADER
// ============================================================================

class _HomeHeader extends StatelessWidget {
  final VoidCallback onBookingsPressed;

  const _HomeHeader({
    required this.onBookingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // YiLink logo
        SizedBox(
          width: 48,
          height: 48,
          child: Image.asset(
            'assets/images/YILINK-logo.png',
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.local_hospital_rounded,
                  color: AppColors.primary,
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 12),

        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'YiLink Health',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Healthcare made easier',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        _HeaderButton(
          icon: Icons.calendar_month_outlined,
          onPressed: onBookingsPressed,
        ),

        const SizedBox(width: 8),

        _HeaderButton(
          icon: Icons.notifications_none_rounded,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _HeaderButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.border,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
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
// SEARCH
// ============================================================================

class _SearchBar extends StatelessWidget {
  final VoidCallback onTap;

  const _SearchBar({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.search_rounded,
                size: 22,
                color: AppColors.primary,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Search hospitals, specialties or packages',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              Icon(
                Icons.tune_rounded,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// HERO
// ============================================================================

class _HeroBanner extends StatelessWidget {
  final VoidCallback onExplorePressed;

  const _HeroBanner({
    required this.onExplorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: AppColors.primary,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Replace this URL later with your own YiLink hero asset if desired.
            Image.asset(
              'assets/images/yilink-home-hero.png',
          width: double.infinity,
          height: double.infinity,
            fit: BoxFit.cover
          ),

          // Dark overlay for readable text
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.10),
                  Colors.black.withValues(alpha: 0.72),
                ],
              ),
            ),
          ),

          Positioned(
            top: 18,
            left: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Trusted Healthcare',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'World-class healthcare\nin Malaysia',
                  style: TextStyle(
                    fontSize: 25,
                    height: 1.08,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Connect with trusted hospitals and plan your '
                  'healthcare journey with confidence.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 15),

                FilledButton.icon(
                  onPressed: onExplorePressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(
                    Icons.search_rounded,
                    size: 18,
                  ),
                  label: const Text(
                    'Explore Hospitals',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SECTION TITLE
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const _SectionTitle({
    required this.title,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        if (actionText != null)
          TextButton(
            onPressed: onActionPressed,
            child: Text(
              actionText!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================================
// QUICK ACTION
// ============================================================================

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 115,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                title,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                subtitle,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 9,
                  color: AppColors.textSecondary,
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
// SPECIALTY
// ============================================================================

class _SpecialtyChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SpecialtyChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 10,
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
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              size: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
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
// FIREBASE HOSPITALS
// ============================================================================

class _FeaturedHospitals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Hospital>>(
      stream: FirebaseHospitalService().getHospitals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 255,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  color: AppColors.primary,
                  size: 30,
                ),
                SizedBox(height: 10),
                Text(
                  'Unable to load hospitals.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        final hospitals = (snapshot.data ?? [])
            .take(5)
            .toList();

        if (hospitals.isEmpty) {
          return const SizedBox(
            height: 120,
            child: Center(
              child: Text(
                'No hospitals available.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          );
        }

        return SizedBox(
          height: 265,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: hospitals.length,
            separatorBuilder: (_, __) =>
                const SizedBox(width: 14),
            itemBuilder: (context, index) {
              return _FeaturedHospitalCard(
                hospital: hospitals[index],
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================================
// HOSPITAL CARD
// ============================================================================

class _FeaturedHospitalCard extends StatelessWidget {
  final Hospital hospital;

  const _FeaturedHospitalCard({
    required this.hospital,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HospitalDetailsScreen(
                hospital: hospital,
              ),
            ),
          );
        },
        child: Container(
          width: 235,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: AppColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(21),
                ),
                child: SizedBox(
                  height: 145,
                  width: double.infinity,
                  child: hospital.imageUrl.isNotEmpty
                      ? Image.network(
                          hospital.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const _HospitalFallback(),
                        )
                      : const _HospitalFallback(),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    14,
                    13,
                    14,
                    13,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.25,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const Spacer(),

                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: AppColors.primary,
                          ),

                          const SizedBox(width: 4),

                          Expanded(
                            child: Text(
                              hospital.city.isNotEmpty
                                  ? hospital.city
                                  : hospital.state,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                color:
                                    AppColors.textSecondary,
                              ),
                            ),
                          ),

                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                    ],
                  ),
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
// HOSPITAL FALLBACK
// ============================================================================

class _HospitalFallback extends StatelessWidget {
  const _HospitalFallback();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryLight,
      child: const Center(
        child: Icon(
          Icons.local_hospital_rounded,
          size: 45,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// ============================================================================
// MEDICAL TOURISM
// ============================================================================

class _MedicalTourismCard extends StatelessWidget {
  const _MedicalTourismCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.flight_takeoff_rounded,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'Planning treatment\nin Malaysia?',
            style: TextStyle(
              fontSize: 22,
              height: 1.15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 9),

          const Text(
            'YiLink helps connect your healthcare journey — '
            'from finding hospitals and treatment packages to '
            'planning your medical visit.',
            style: TextStyle(
              fontSize: 13,
              height: 1.5,
              color: Colors.white70,
            ),
          ),

          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                SizedBox(width: 6),
                Text(
                  'Healthcare • Travel • Support',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}