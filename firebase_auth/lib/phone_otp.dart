import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import './wrapper.dart';

class Phoneverification extends StatefulWidget {
  const Phoneverification({super.key});

  @override
  State<Phoneverification> createState() => _PhoneverificationState();
}

class _PhoneverificationState extends State<Phoneverification> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? _verificationId;
  bool _isLoading = false;
  bool _otpSent = false;

  //Send otp
  Future<void> sendOtp() async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneController.text.trim(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // auto verification
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offAll(() => const Wrapper());
      },
      verificationFailed: (FirebaseAuthException e) {
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
          _otpSent = true;
          _isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }
  //Verify otp

  Future<void> verifyOtp() async {
    if (_verificationId == null) {
      Get.snackbar(
        'Error',
        'Please request OTP first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });
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
        e.message ?? 'Error',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Login')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              enabled: !_otpSent,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: '+91XXXXXXXXXX',
              ),
            ),
            const SizedBox(height: 16),

            if (_otpSent)
              Pinput(
                controller: otpController,
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  // You can add any logic here when OTP changes
                },
                onCompleted: (pin) {
                  // Optional: Auto-verify when all digits are entered
                  // verifyOtp();
                },
              ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : _otpSent
                    ? verifyOtp
                    : sendOtp,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(_otpSent ? 'Verify OTP' : 'Send OTP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
