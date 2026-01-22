import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import './wrapper.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({super.key});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? _verificationId;
  int? _resendToken;

  bool _isLoading = false;
  bool _otpSent = false;

  // 📩 SEND OTP
  Future<void> sendOtp() async {
    final phone = phoneController.text.trim();

    if (!phone.startsWith('+') || phone.length < 10) {
      Get.snackbar(
        'Invalid Phone Number',
        'Enter number with country code (e.g. +91XXXXXXXXXX)',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => _isLoading = true);

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),

      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offAll(() => const Wrapper());
      },

      verificationFailed: (FirebaseAuthException e) {
        setState(() => _isLoading = false);
        Get.snackbar(
          'Verification Failed',
          e.message ?? 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },

      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationId = verificationId;
          _resendToken = resendToken;
          _otpSent = true;
          _isLoading = false;
        });
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },

      forceResendingToken: _resendToken,
    );
  }

  // 🔐 VERIFY OTP
  Future<void> verifyOtp() async {
    if (_verificationId == null || otpController.text.length < 6) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter the 6-digit OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpController.text.trim(),
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(() => const Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Invalid OTP',
        e.message ?? 'Verification failed',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Phone Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter your phone number to receive a verification code',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 48),
              TextField(
                controller: phoneController,
                enabled: !_otpSent,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: '+1 123 456 7890',
                  prefixIcon: Icon(Icons.phone_android_outlined),
                ),
              ),
              const SizedBox(height: 24),
              if (_otpSent) ...[
                const Text(
                  'Enter 6-digit code',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white54,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Pinput(
                    controller: otpController,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        border: Border.all(color: Colors.deepPurpleAccent),
                      ),
                    ),
                    onCompleted: (pin) => verifyOtp(),
                  ),
                ),
                const SizedBox(height: 32),
              ],
              ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : _otpSent
                    ? verifyOtp
                    : sendOtp,
                child: _isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        _otpSent
                            ? 'Verify & Continue'
                            : 'Get Verification Code',
                      ),
              ),
              if (_otpSent) ...[
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: _isLoading ? null : sendOtp,
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
