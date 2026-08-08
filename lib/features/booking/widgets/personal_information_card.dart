import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class PersonalInformationCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController nationalityController;

  final bool loggedIn;

  const PersonalInformationCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.nationalityController,
    required this.loggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                color: AppColors.primary,
              ),
              SizedBox(width: 10),
              Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            "Tell us how we can contact you.",
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          _BookingField(
            label: "Full Name",
            controller: nameController,
            icon: Icons.person_outline,
          ),

          const SizedBox(height: 18),

          _BookingField(
            label: "Email Address",
            controller: emailController,
            enabled: !loggedIn,
            keyboardType: TextInputType.emailAddress,
            icon: Icons.email_outlined,
          ),

          const SizedBox(height: 18),

          _BookingField(
            label: "Phone Number",
            controller: phoneController,
            keyboardType: TextInputType.phone,
            icon: Icons.phone_outlined,
          ),

          const SizedBox(height: 18),

          _BookingField(
            label: "Nationality",
            controller: nationalityController,
            icon: Icons.public,
          ),
        ],
      ),
    );
  }
}

class _BookingField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool enabled;
  final TextInputType keyboardType;

  const _BookingField({
    required this.label,
    required this.icon,
    required this.controller,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "$label is required";
            }
            return null;
          },
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: AppColors.primary,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}