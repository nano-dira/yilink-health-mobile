import 'package:flutter/material.dart';

class EmergencyNotice extends StatelessWidget {
  const EmergencyNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EA),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFF3D38A),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFC58A00),
            size: 28,
          ),

          SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  "Medical Emergency Notice",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF8A5C00),
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "This booking form is intended for consultation requests only. "
                  "If you are experiencing a medical emergency, "
                  "please contact your local emergency services or "
                  "visit the nearest Emergency Department immediately.",
                  style: TextStyle(
                    height: 1.6,
                    color: Color(0xFF805B18),
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