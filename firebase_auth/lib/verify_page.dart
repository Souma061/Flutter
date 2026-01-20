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
        title: const Text('Verify Email'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: signOut,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'A verification link has been sent to your email address. Please verify your email to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: reload,
              child: const Text('I have verified my email'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendVerifyLink,
              child: const Text('Resend Verification Email'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: signOut,
              child: const Text('Back to Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
