import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class LoginRequiredCard extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onWhatsApp;

  const LoginRequiredCard({
    super.key,
    required this.onLogin,
    required this.onWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          width: 520,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 86,
                height: 86,
                decoration: const BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.health_and_safety_outlined,
                  color: AppColors.primary,
                  size: 42,
                ),
              ),

              const SizedBox(height: 28),

              const Text(
                "Choose How You'd Like to Continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 14),

              const Text(
                "Book your consultation through YiLink to enjoy a personalised healthcare journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.6,
                  color: AppColors.textSecondary,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 28),

              const _BenefitTile(
                icon: Icons.check_circle_outline,
                text: "Track your consultation requests",
              ),

              const SizedBox(height: 12),

              const _BenefitTile(
                icon: Icons.notifications_active_outlined,
                text: "Receive appointment updates",
              ),

              const SizedBox(height: 12),

              const _BenefitTile(
                icon: Icons.history_outlined,
                text: "View your booking history",
              ),

              const SizedBox(height: 12),

              const _BenefitTile(
                icon: Icons.favorite_outline,
                text: "Manage your healthcare journey",
              ),

              const SizedBox(height: 34),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton.icon(
                  onPressed: onLogin,
                  icon: const Icon(Icons.login_rounded),
                  label: const Text(
                    "Continue with Google",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Need a quick response without creating an account?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: onWhatsApp,
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text(
                    "Continue via WhatsApp",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.green,
                    side: const BorderSide(
                      color: Colors.green,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              const Text(
                "You can chat directly with our healthcare coordinator for enquiries or assistance.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BenefitTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const _BenefitTile({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: AppColors.primary,
          size: 22,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}