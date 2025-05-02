import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // Controller untuk email dan password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Global key untuk validasi form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Fungsi untuk login
  void login() {
    // Misalnya, login dengan mengecek email dan password yang dimasukkan
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Kamu bisa tambahkan validasi lebih lanjut atau logika login di sini
    if (email == 'admin@domain.com' && password == 'password') {
      Get.snackbar('Success', 'Login Successful');
      // Arahkan ke halaman berikutnya, misalnya dashboard
      // Get.offNamed('/dashboard');
    } else {
      Get.snackbar('Error', 'Invalid email or password');
    }
  }
}
