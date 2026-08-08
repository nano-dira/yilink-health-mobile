import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/booking.dart';
import '../../../services/booking_service.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Bookings",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ),

      body: StreamBuilder<List<Booking>>(
        stream: BookingService.instance.getCurrentUserBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  snapshot.error.toString(),
                ),
              ),
            );
          }

          final bookings = snapshot.data ?? [];

          if (bookings.isEmpty) {
            return const _EmptyBookings();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: bookings.length,
            itemBuilder: (_, index) {
              return BookingCard(
                booking: bookings[index],
              );
            },
          );
        },
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({
    super.key,
    required this.booking,
  });

  Color get statusColor {
    switch (booking.status.toLowerCase()) {
      case "pending review":
        return Colors.orange;

      case "confirmed":
        return Colors.green;

      case "completed":
        return Colors.blue;

      case "cancelled":
        return Colors.red;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      booking.hospitalName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      booking.bookingNo,
                      style: const TextStyle(
                        fontSize: 12,
                        color:
                            AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          _InfoRow(
            icon: Icons.medical_services_outlined,
            title: "Treatment",
            value: booking.treatment,
          ),

          _InfoRow(
            icon: Icons.calendar_today_outlined,
            title: "Preferred Date",
            value: booking.preferredDate.isEmpty
                ? "Not specified"
                : booking.preferredDate,
          ),

          _InfoRow(
            icon: Icons.schedule,
            title: "Submitted",
            value:
                "${booking.createdAt.day}/${booking.createdAt.month}/${booking.createdAt.year}",
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(.12),
              borderRadius:
                  BorderRadius.circular(30),
            ),
            child: Text(
              booking.status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [

          Icon(
            icon,
            size: 18,
            color: AppColors.primary,
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 110,
            child: Text(
              title,
              style: const TextStyle(
                color:
                    AppColors.textSecondary,
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyBookings extends StatelessWidget {
  const _EmptyBookings();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            Icon(
              Icons.calendar_month_outlined,
              size: 90,
              color: AppColors.primary,
            ),

            const SizedBox(height: 24),

            const Text(
              "No bookings yet",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Your consultation requests will appear here after you submit a booking.",
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}