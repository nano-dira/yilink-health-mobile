import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() =>
      _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _authService = AuthService();

  bool _loading = false;
  String? _errorMessage;

  Future<void> _signIn() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage =
            'Unable to sign in with Google. Please try again.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // ==================================================
              // BRAND
              // ==================================================

              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  size: 38,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'YiLink Health',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Healthcare made easier',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: 50),

              // ==================================================
              // LOGIN CARD
              // ==================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: AppColors.border,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.person_outline_rounded,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Welcome to YiLink',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Sign in to manage your profile, bookings and healthcare journey.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed:
                            _loading ? null : _signIn,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(
                            color: AppColors.border,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color:
                                      AppColors.primary,
                                ),
                              )
                            : const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'G',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight:
                                          FontWeight.w800,
                                      color: Color(
                                        0xFF4285F4,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight:
                                          FontWeight.w600,
                                      color: AppColors
                                          .textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),

                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline_rounded,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Secure authentication powered by Google',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}