import '../models/booking.dart';

class MockBookingService {
  static final List<Booking> _bookings = [];

  static List<Booking> get bookings => _bookings;

  static void addBooking(Booking booking) {
    _bookings.insert(0, booking);
  }
}