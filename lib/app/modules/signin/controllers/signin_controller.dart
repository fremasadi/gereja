import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repository/auth_repository.dart';

class SigninController extends GetxController {
  // Controller untuk email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Global key untuk validasi form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Repository
  final AuthRepository authRepo = AuthRepository();

  // Loading state
  final RxBool isLoading = false.obs;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    showLoading(); // Tampilkan loading
    isLoading.value = true;

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await authRepo.login(email: email, password: password);

      Get.snackbar('Success', 'Login Successful');
      Get.offNamed('/base');
    } catch (e) {
      // Get.snackbar('Error', e.toString());
    } finally {
      hideLoading(); // Sembunyikan loading
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Di dalam LoginController Anda
  void showLoading() {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen ?? false) Get.back();
  }
}