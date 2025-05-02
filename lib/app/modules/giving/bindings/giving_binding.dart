import 'package:get/get.dart';

import '../controllers/giving_controller.dart';

class GivingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GivingController>(
      () => GivingController(),
    );
  }
}
