import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class SuccessDialog extends StatelessWidget {
  final String bookingNo;
  final VoidCallback onClose;

  const SuccessDialog({
    super.key,
    required this.bookingNo,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            const CircleAvatar(
              radius: 36,
              backgroundColor: AppColors.primaryLight,
              child: Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 42,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Consultation Submitted",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              "Your consultation request has been successfully submitted.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 22),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [

                  const Text(
                    "Booking Number",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    bookingNo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onClose,
                child: const Text("Done"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}