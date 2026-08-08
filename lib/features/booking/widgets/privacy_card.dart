import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class PrivacyCard extends StatelessWidget {
  final bool consent;
  final ValueChanged<bool?> onChanged;

  const PrivacyCard({
    super.key,
    required this.consent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.primary.withOpacity(.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Row(
            children: [

              Icon(
                Icons.shield_outlined,
                color: AppColors.primary,
              ),

              SizedBox(width: 10),

              Text(
                "Privacy & Consent",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

            ],
          ),

          const SizedBox(height: 18),

          CheckboxListTile(
            value: consent,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            controlAffinity:
                ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
            title: const Text(
              "I consent to YiLink Health collecting my information for healthcare coordination and booking purposes.",
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            "Do not include passwords, payment card information or highly sensitive medical records.",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}