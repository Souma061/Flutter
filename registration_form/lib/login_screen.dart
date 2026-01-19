import 'package:flutter/material.dart';
import 'package:registration_form/palette.dart';
import 'package:registration_form/widgets/gradient_button.dart';
import 'package:registration_form/widgets/login_field.dart';
import 'package:registration_form/widgets/social_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() {
    // Add your login logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/images/signin_balls.png'),
              const Text(
                'Signup',
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
              LoginField(hintText: 'Email', controller: emailController),
              const SizedBox(height: 20),
              LoginField(
                hintText: 'Password',
                controller: passwordController,
                isObscure: true,
              ),
              const SizedBox(height: 30),
              SubmitButton(onPressed: loginUser, text: 'Signup'),
            ],
          ),
        ),
      ),
    );
  }
}
