import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/constants/const_color.dart';
import '../../../routes/app_pages.dart';
import '../../widgets/input_form_button.dart';
import '../../widgets/input_text_form_field.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});
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
                'Get started',
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
                controller: controller.nameController,
                hint: 'Enter Full Name',
                isSecureField: false,
                autoCorrect: false,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                hintTextSize: 14.sp,
              ),
              SizedBox(height: 12.h),
              // Password Field
              InputTextFormField(
                controller: controller.emailController,
                hint: 'Enter Email',
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
              SizedBox(height: 12.h),
              // Password Field
              InputTextFormField(
                controller: controller.passwordController,
                hint: 'Enter  password',
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
                    controller.register();
                  }
                },
                titleText: 'Signup',
                color: ConstColor.primaryColor,
              ),
          
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.SIGNIN),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'SignIn',
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
