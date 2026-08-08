import 'package:url_launcher/url_launcher.dart';

class WhatsAppBookingService {

  static const String adminWhatsAppNumber = '6285286032242';

  static Future<void> sendBooking({
    required String hospitalName,
    required String treatment,
    required String preferredDate,
    required String patientName,
    required String phone,
    required String email,
    required String nationality,
    required String notes,
  }) async {
    final message = '''
Hello YiLink Health,

I would like to request a medical consultation.

🏥 Hospital:
$hospitalName

🩺 Treatment / Specialty:
$treatment

📅 Preferred Date:
$preferredDate

👤 Patient Details
Name: $patientName
Nationality: $nationality
Phone: $phone
Email: $email

📝 Additional Notes:
${notes.trim().isEmpty ? 'None' : notes.trim()}

Thank you.
''';

    final encodedMessage = Uri.encodeComponent(message);

    final uri = Uri.parse(
      'https://wa.me/$adminWhatsAppNumber?text=$encodedMessage',
    );

    final opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!opened) {
      throw Exception('Unable to open WhatsApp.');
    }
  }
}