import 'package:get/get.dart';

import '../../../data/services/auth_service.dart';

class HomeController extends GetxController {
  final AuthService authService = AuthService();
  var userName = ''.obs;

  Future<void> loadUserName() async {
    final name = await authService.getUserName();
    if (name != null) {
      userName.value = name;
    }
  }
}
