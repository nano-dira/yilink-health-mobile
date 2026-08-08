import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/constants/app_colors.dart';
import '../../../models/hospital.dart';
import '../../../services/booking_service.dart';
import '../../profile/screens/profile_screen.dart';

import '../widgets/booking_hero.dart';
import '../widgets/login_status_card.dart';
import '../widgets/personal_information_card.dart';
import '../widgets/healthcare_request_card.dart';
import '../widgets/privacy_card.dart';
import '../widgets/booking_bottom_bar.dart';
import '../widgets/success_dialog.dart';
import '../widgets/emergency_notice.dart';
import '../widgets/login_required_card.dart';


class BookingScreen extends StatefulWidget {
  final Hospital? hospital;

  const BookingScreen({
    super.key,
    this.hospital,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  //==============================================================
  // SERVICES
  //==============================================================

  final BookingService _bookingService = BookingService.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  //==============================================================
  // FORM CONTROLLERS
  //==============================================================

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalityController = TextEditingController();

  final _treatmentController = TextEditingController();
  final _notesController = TextEditingController();

  //==============================================================
  // STATE
  //==============================================================

  Hospital? _selectedHospital;
  DateTime? _preferredDate;

  bool _consent = false;
  bool _isSubmitting = false;

  String _bookingNumber = "";

  //==============================================================
  // INITIALIZE
  //==============================================================

  @override
  void initState() {
    super.initState();

    _selectedHospital = widget.hospital;

    if (currentUser != null) {
      _nameController.text = currentUser!.displayName ?? "";
      _emailController.text = currentUser!.email ?? "";
    }
  }

  //==============================================================
  // DATE PICKER
  //==============================================================

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        _preferredDate = picked;
      });
    }
  }

//==============================================================
// SUBMIT BOOKING
//==============================================================

Future<void> _submitBooking() async {

  // Require login first
  if (currentUser == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Please sign in before submitting a consultation request.",
        ),
      ),
    );
    return;
  }

  // Hospital validation
  if (_selectedHospital == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please select a hospital."),
      ),
    );
    return;
  }

  // Consent validation
  if (!_consent) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please accept the Privacy Policy."),
      ),
    );
    return;
  }

  setState(() {
    _isSubmitting = true;
  });

  try {
    final bookingNo = await _bookingService.createBooking(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      nationality: _nationalityController.text.trim(),
      hospitalId: _selectedHospital!.id,
      hospitalName: _selectedHospital!.name,
      hospitalPackage: "",
      treatment: _treatmentController.text.trim(),
      preferredDate: _preferredDate,
      notes: _notesController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      _bookingNumber = bookingNo;
      _isSubmitting = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => SuccessDialog(
        bookingNo: bookingNo,
        onClose: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  } catch (e) {
    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
}

  //==============================================================
  // WHATSAPP
  //==============================================================

  Future<void> _continueWhatsApp() async {
    // Replace this with your existing WhatsApp implementation.
  }

  //==============================================================
  // BUILD
  //==============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Request Consultation",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      bottomNavigationBar: currentUser == null
        ? null
        : BookingBottomBar(
            isSubmitting: _isSubmitting,
            onSubmit: _submitBooking,
            onWhatsApp: _continueWhatsApp,
      ),

      body: currentUser == null
    ? LoginRequiredCard(
        onLogin: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProfileScreen(),
            ),
          );
        },
        onWhatsApp: _continueWhatsApp,
      )
    : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BookingHero(),

            const SizedBox(height: 24),

            LoginStatusCard(
              loggedIn: true,
              isLoading: false,
              name: currentUser?.displayName ?? "YiLink User",
              email: currentUser?.email ?? "",
            ),

            const SizedBox(height: 24),

            PersonalInformationCard(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
              nationalityController: _nationalityController,
              loggedIn: true,
            ),

            const SizedBox(height: 24),

            HealthcareRequestCard(
              selectedHospital: _selectedHospital,
              onHospitalChanged: (hospital) {
                setState(() {
                  _selectedHospital = hospital;
                });
              },
              treatmentController: _treatmentController,
              notesController: _notesController,
              preferredDate: _preferredDate,
              onSelectDate: _selectDate,
            ),

            const SizedBox(height: 24),

            const EmergencyNotice(),

            const SizedBox(height: 24),

            PrivacyCard(
              consent: _consent,
              onChanged: (value) {
                setState(() {
                  _consent = value ?? false;
                });
              },
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  //==============================================================
  // CLEAN UP
  //==============================================================

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalityController.dispose();
    _treatmentController.dispose();
    _notesController.dispose();

    super.dispose();
  }
}