import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BookingHero extends StatelessWidget {
  const BookingHero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff0F766E),
            Color(0xff14B8A6),
          ],
        ),
      ),

      child: Stack(
        children: [

          Positioned(
            right: -25,
            top: -25,
            child: Icon(
              Icons.health_and_safety_outlined,
              size: 140,
              color: Colors.white.withOpacity(.08),
            ),
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(40),
                ),
                child: const Text(
                  "YILINK HEALTH",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    fontSize: 11,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                "Request a\nConsultation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Connect with trusted hospitals across Malaysia and submit your healthcare request securely. Our coordinators will contact you within 1–2 business days.",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  height: 1.7,
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [

                  _Badge(
                    icon: Icons.verified,
                    text: "Verified Hospitals",
                  ),

                  const SizedBox(width: 10),

                  _Badge(
                    icon: Icons.flight_takeoff,
                    text: "Medical Travel",
                  ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _Badge({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.12),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: Colors.white24,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          Icon(
            icon,
            size: 16,
            color: Colors.white,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),

        ],
      ),
    );
  }
}