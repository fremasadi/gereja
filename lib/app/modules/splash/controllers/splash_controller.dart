import 'package:gereja/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    // Tambahkan delay 2 detik untuk splash screen
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final name = prefs.getString('name');

    if (token != null && token.isNotEmpty && name != null && name.isNotEmpty) {
      // Jika token dan name ada, langsung ke home
      Get.offNamed(Routes.BASE); // Ganti dengan route home Anda
    } else {
      // Jika tidak ada, ke halaman signin
      Get.offNamed(Routes.SIGNIN);
    }
  }
}