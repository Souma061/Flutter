import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './signup_page.dart' as signup;
import './wrapper.dart' as wrapper;

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  @override
  void initState() {
    sendVerifyLink();
    super.initState();
  }

  dynamic sendVerifyLink() async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.sendEmailVerification().then(
      (value) => {
        Get.snackbar(
          'Verification Email',
          'A verification link has been sent to your email address.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        ),
      },
    );
  }

  dynamic reload() async {
    await FirebaseAuth.instance.currentUser?.reload();
    if (mounted) {
      Get.offAll(() => const wrapper.Wrapper());
    }
  }

  dynamic signOut() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Get.offAll(() => const signup.SignupPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Verification'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: signOut,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mark_email_read_outlined,
                  size: 80,
                  color: Colors.deepPurpleAccent,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Check your email',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'We\'ve sent a verification link to your email address. Please click the link to verify your account.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.6),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: reload,
                child: const Text('I have verified'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: sendVerifyLink,
                child: const Text(
                  'Resend Link',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: signOut,
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white.withOpacity(0.6),
                ),
                child: const Text('Use a different account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
