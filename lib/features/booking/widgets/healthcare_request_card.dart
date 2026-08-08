import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/hospital.dart';
import '../../../services/firebase_hospital_service.dart';

class HealthcareRequestCard extends StatelessWidget {
  final Hospital? selectedHospital;
  final ValueChanged<Hospital> onHospitalChanged;

  final TextEditingController treatmentController;
  final TextEditingController notesController;

  final DateTime? preferredDate;
  final VoidCallback onSelectDate;

  const HealthcareRequestCard({
    super.key,
    required this.selectedHospital,
    required this.onHospitalChanged,
    required this.treatmentController,
    required this.notesController,
    required this.preferredDate,
    required this.onSelectDate,
  });

  String get formattedDate {
    if (preferredDate == null) {
      return "Select preferred date";
    }

    return "${preferredDate!.day.toString().padLeft(2, '0')}/"
        "${preferredDate!.month.toString().padLeft(2, '0')}/"
        "${preferredDate!.year}";
  }

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
                Icons.medical_services_outlined,
                color: AppColors.primary,
              ),
              SizedBox(width: 10),
              Text(
                "Healthcare Request",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          const Text(
            "Tell us about the healthcare service you require.",
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Preferred Hospital",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          StreamBuilder<List<Hospital>>(
            stream: FirebaseHospitalService().getHospitals(),
            builder: (context, snapshot) {
                final hospitals = snapshot.data ?? [];

                if (snapshot.connectionState == ConnectionState.waiting &&
                    hospitals.isEmpty) {
                return const Center(
                    child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                    ),
                );
                }

                // Remove duplicate hospitals by ID
                final Map<String, Hospital> uniqueHospitals = {};

                for (final hospital in hospitals) {
                uniqueHospitals[hospital.id] = hospital;
                }

                // Add hospital from Hospital Details if it doesn't exist yet
                if (selectedHospital != null &&
                    !uniqueHospitals.containsKey(selectedHospital!.id)) {
                uniqueHospitals[selectedHospital!.id] = selectedHospital!;
                }

                final hospitalList = uniqueHospitals.values.toList();

                // Only use the selected ID if it actually exists
                String? selectedId;

                if (selectedHospital != null &&
                    uniqueHospitals.containsKey(selectedHospital!.id)) {
                selectedId = selectedHospital!.id;
                }

                return DropdownButtonFormField<String>(
                value: selectedId,
                isExpanded: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                    Icons.local_hospital_outlined,
                    color: AppColors.primary,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    ),
                ),
                items: hospitalList.map((hospital) {
                    return DropdownMenuItem<String>(
                    value: hospital.id,
                    child: Text(
                        hospital.name,
                        overflow: TextOverflow.ellipsis,
                    ),
                    );
                }).toList(),
                onChanged: (hospitalId) {
                    if (hospitalId == null) return;

                    final hospital = hospitalList.firstWhere(
                    (h) => h.id == hospitalId,
                    );

                    onHospitalChanged(hospital);
                },
                validator: (value) {
                    if (value == null || value.isEmpty) {
                    return "Please select a hospital";
                    }
                    return null;
                },
                );
            },
        ),

          const SizedBox(height: 18),

          const Text(
            "Treatment / Service",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: treatmentController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Treatment is required";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.favorite_outline,
                color: AppColors.primary,
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              hintText: "e.g. Cardiology Consultation",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "Preferred Consultation Date",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          InkWell(
            onTap: onSelectDate,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.border,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.primary,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        color: preferredDate == null
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                      ),
                    ),
                  ),

                  const Icon(
                    Icons.arrow_drop_down,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "Additional Notes",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          TextFormField(
            controller: notesController,
            minLines: 4,
            maxLines: 6,
            decoration: InputDecoration(
              hintText:
                  "Tell us more about your medical enquiry...",
              prefixIcon: const Padding(
                padding: EdgeInsets.only(bottom: 70),
                child: Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.primary,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}