import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './verify_page.dart' as verify;
import 'homepage.dart' as homepage;
import 'login_page.dart' as login;

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Handle connection states
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle errors from the stream
          if (snapshot.hasError) {
            return _errorScreen('Authentication Error', snapshot.error.toString());
          }

          // Handle authenticated users
          if (snapshot.hasData) {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null && !user.emailVerified) {
              return verify.Verify();
            } else {
              return homepage.HomePage();
            }
          }

          // Handle unauthenticated users
          return login.LoginPage();
        },
      ),
    );
  }

  Widget _errorScreen(String title, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(message, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => setState(() {}),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
