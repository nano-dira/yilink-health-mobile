import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/hospital.dart';

class HospitalCard extends StatelessWidget {
  final Hospital hospital;
  final VoidCallback onTap;

  const HospitalCard({
    super.key,
    required this.hospital,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Temporary image placeholder
            ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: hospital.imageUrl.isNotEmpty
                      ? Image.network(
                          hospital.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return Container(
                              color: AppColors.primaryLight,
                              child: const Center(
                                child: Icon(
                                  Icons.local_hospital_rounded,
                                  size: 55,
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.primaryLight,
                          child: const Center(
                            child: Icon(
                              Icons.local_hospital_rounded,
                              size: 55,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hospital.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(
                        Icons.star_rounded,
                        size: 20,
                        color: Colors.amber,
                      ),
                      Text(
                        hospital.rating.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${hospital.city}, Malaysia',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: hospital.specialties
                        .take(3)
                        .map(
                          (specialty) => Chip(
                            label: Text(
                              specialty,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 14),

                  const Row(
                    children: [
                      Text(
                        'View Hospital',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}