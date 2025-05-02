import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/input_text_form_field.dart';
import '../controllers/signin_controller.dart';


class SigninView extends GetView<SigninController> {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login to your account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32), // space between title and form

            // Email Field
            InputTextFormField(
              controller: controller.emailController,
              hint: 'Enter your email',
              isSecureField: false,
              autoCorrect: false,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
              hintTextSize: 16,
            ),
            const SizedBox(height: 16),

            // Password Field
            InputTextFormField(
              controller: controller.passwordController,
              hint: 'Enter your password',
              isSecureField: true,
              autoCorrect: false,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
              hintTextSize: 16,
            ),
            const SizedBox(height: 32),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (controller.formKey.currentState?.validate() ?? false) {
                    controller.login();
                  }
                },
                child: const Text('Login', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
