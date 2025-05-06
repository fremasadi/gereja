import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repository/auth_repository.dart';

class SignupController extends GetxController {
  // Controller untuk input
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Global key untuk validasi form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Repository
  final AuthRepository authRepo = AuthRepository();

  // Loading state
  final RxBool isLoading = false.obs;

  // Fungsi untuk register
  Future<void> register() async {
    // Periksa null state dan validasi form dengan aman
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }

    isLoading.value = true;
    try {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      // Validasi tambahan untuk memastikan field tidak kosong
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        throw Exception('Please fill all fields');
      }

      final response = await authRepo.register(
        name: name,
        email: email,
        password: password,
      );

      // Pastikan response tidak null sebelum melanjutkan
      if (response != null) {
        Get.snackbar(
          'Success',
          'Registration Successful',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
        _clearForm();
        Get.offNamed('/login');
      }
    } catch (e) {
      // // Penanganan error yang lebih baik
      // final errorMessage = e.toString().replaceFirst('Exception: ', '');
      // Get.snackbar(
      //   'Error',
      //   errorMessage.isNotEmpty ? errorMessage : 'An unknown error occurred',
      //   snackPosition: SnackPosition.BOTTOM,
      //   duration: const Duration(seconds: 3),
      //   colorText: Colors.white,
      //   backgroundColor: Colors.red,
      // );
    } finally {
      isLoading.value = false;
    }
  }

  // Fungsi untuk membersihkan form
  void _clearForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}