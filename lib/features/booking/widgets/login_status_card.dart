import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class LoginStatusCard extends StatelessWidget {
  final bool loggedIn;
  final bool isLoading;
  final String name;
  final String email;

  const LoginStatusCard({
    super.key,
    required this.loggedIn,
    required this.isLoading,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            SizedBox(width: 15),
            Text("Loading your YiLink profile..."),
          ],
        ),
      );
    }

    if (loggedIn) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              child: Icon(Icons.person),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Signed in",
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.verified,
              color: Colors.green,
            ),
          ],
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(.08),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.orange,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "You're continuing as a guest. Sign in to track bookings and receive healthcare updates.",
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}