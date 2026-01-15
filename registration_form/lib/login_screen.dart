import 'package:flutter/material.dart';
import 'package:registration_form/palette.dart';
import 'package:registration_form/widgets/gradient_button.dart';
import 'package:registration_form/widgets/login_field.dart';
import 'package:registration_form/widgets/social_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Login',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              SocialButton(
                iconPath: 'assets/svgs/g_logo.svg',
                label: 'Sign in with Google',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              SocialButton(
                iconPath: 'assets/svgs/f_logo.svg',
                label: 'Sign in with Facebook',
                horizontalPadding: 50,
                onPressed: () {},
              ),

              const SizedBox(height: 20),
              const Text(
                'Or',
                style: TextStyle(color: Pallete.whiteColor, fontSize: 16),
              ),
              const SizedBox(height: 30),
              const LoginField(hintText: 'Email'),
              const SizedBox(height: 20),
              const LoginField(hintText: 'Password'),
              const SizedBox(height: 30),
              const SubmitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
