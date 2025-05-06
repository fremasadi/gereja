import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/const_color.dart';
import 'package:gereja/app/modules/widgets/input_form_button.dart';
import 'package:gereja/app/routes/app_pages.dart';
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
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Bold',
                  color: ConstColor.primaryColor,
                ),
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
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                hintTextSize: 14.sp,
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
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                hintTextSize: 14.sp,
              ),
              SizedBox(height: 28.h),
              InputFormButton(
                onClick: () {
                  if (controller.formKey.currentState?.validate() ?? false) {
                    controller.login();
                  }
                },
                titleText: 'Login',
                color: ConstColor.primaryColor,
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.SIGNUP),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dont have account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'SignUp',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ConstColor.primaryColor,
                        fontFamily: 'SemiBold',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
