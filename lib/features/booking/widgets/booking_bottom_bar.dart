import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class BookingBottomBar extends StatelessWidget {
  final bool isSubmitting;
  final VoidCallback onSubmit;
  final VoidCallback onWhatsApp;

  const BookingBottomBar({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
    required this.onWhatsApp,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          20,
          14,
          20,
          18,
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
              color: Colors.black.withOpacity(.05),
              blurRadius: 20,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed:
                    isSubmitting
                        ? null
                        : onSubmit,
                icon: isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.check_circle_outline,
                      ),
                label: Text(
                  isSubmitting
                      ? "Submitting..."
                      : "Submit to YiLink",
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: OutlinedButton.icon(
                onPressed:
                    isSubmitting
                        ? null
                        : onWhatsApp,
                icon: const Icon(
                  Icons.chat,
                ),
                label: const Text(
                  "Continue via WhatsApp",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}