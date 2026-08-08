import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../auth/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalityController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _loading = true;
  bool _saving = false;

  User? get user => FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final currentUser = user;

    if (currentUser == null) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      return;
    }

    try {
      final document = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      final data = document.data();

      _nameController.text =
          data?['displayName']?.toString() ??
          currentUser.displayName ??
          '';

      _emailController.text =
          data?['email']?.toString() ??
          currentUser.email ??
          '';

      _phoneController.text =
          data?['phone']?.toString() ?? '';

      _nationalityController.text =
          data?['nationality']?.toString() ?? '';
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }
  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final currentUser = user;

    if (currentUser == null) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
      return;
    }

    setState(() {
      _saving = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set({
        'uid': currentUser.uid,
        'displayName': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'nationality':
            _nationalityController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Profile updated successfully.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to update profile.',
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  Future<void> _signOut() async {
    await _authService.signOut();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    final currentUser = user;

    if (currentUser == null) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Icon(
                Icons.account_circle_outlined,
                size: 90,
                color: AppColors.primary,
              ),

              const SizedBox(height: 20),

              const Text(
                "Sign in to YiLink Health",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Please sign in with your Google account to continue.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              FilledButton.icon(
                onPressed: () async {
                  await _authService.signInWithGoogle();
                },
                icon: const Icon(Icons.login),
                label: const Text("Continue with Google"),
              ),
            ],
          ),
        ),
      ),
    );
}

    final photoUrl = currentUser.photoURL ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            20,
            22,
            20,
            110,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Manage your YiLink Health account and personal information.',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 24),

                // ================================================
                // PROFILE HERO
                // ================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius:
                        BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 39,
                        backgroundColor: Colors.white24,
                        backgroundImage:
                            photoUrl.isNotEmpty
                                ? NetworkImage(photoUrl)
                                : null,
                        child: photoUrl.isEmpty
                            ? Text(
                                _profileInitial(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight:
                                      FontWeight.w800,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      ),

                      const SizedBox(height: 14),

                      Text(
                        _nameController.text.isEmpty
                            ? 'YiLink User'
                            : _nameController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        _emailController.text,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 14),

                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(
                            alpha: 0.15,
                          ),
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons
                                  .verified_user_outlined,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Google Account Verified',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight:
                                    FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ================================================
                // ACCOUNT DETAILS
                // ================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(24),
                    border: Border.all(
                      color: AppColors.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PERSONAL DETAILS',
                        style: TextStyle(
                          fontSize: 9,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Text(
                        'Account Information',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),

                      const SizedBox(height: 20),

                      _ProfileField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon:
                            Icons.person_outline_rounded,
                      ),

                      const SizedBox(height: 14),

                      _ProfileField(
                        controller: _emailController,
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        enabled: false,
                      ),

                      const SizedBox(height: 14),

                      _ProfileField(
                        controller: _phoneController,
                        label: 'Phone Number',
                        hint: '+60 12 345 6789',
                        icon: Icons.phone_outlined,
                        keyboardType:
                            TextInputType.phone,
                      ),

                      const SizedBox(height: 14),

                      _ProfileField(
                        controller:
                            _nationalityController,
                        label: 'Nationality',
                        hint: 'e.g. Malaysian',
                        icon: Icons.public_rounded,
                      ),

                      const SizedBox(height: 20),

                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color:
                              AppColors.primaryLight,
                          borderRadius:
                              BorderRadius.circular(16),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .shield_outlined,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            SizedBox(width: 11),
                            Expanded(
                              child: Text(
                                'Your account information is securely linked to your authenticated YiLink Health account.',
                                style: TextStyle(
                                  fontSize: 9,
                                  height: 1.5,
                                  color: AppColors
                                      .textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: FilledButton(
                          onPressed:
                              _saving
                                  ? null
                                  : _saveProfile,
                          style:
                              FilledButton.styleFrom(
                            backgroundColor:
                                AppColors.primary,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                      16),
                            ),
                          ),
                          child: _saving
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Save Profile',
                                  style: TextStyle(
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ================================================
                // SIGN OUT
                // ================================================

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: _signOut,
                    icon: const Icon(
                      Icons.logout_rounded,
                    ),
                    label: const Text('Sign Out'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor:
                          Colors.redAccent,
                      side: const BorderSide(
                        color: Colors.redAccent,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _profileInitial() {
    final name = _nameController.text.trim();

    if (name.isNotEmpty) {
      return name.substring(0, 1).toUpperCase();
    }

    final email = _emailController.text.trim();

    if (email.isNotEmpty) {
      return email.substring(0, 1).toUpperCase();
    }

    return 'Y';
  }
}

class _ProfileField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData icon;
  final bool enabled;
  final TextInputType? keyboardType;

  const _ProfileField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.enabled = true,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
          size: 20,
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.border,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}