import 'package:get/get.dart';

import '../controllers/infaq_controller.dart';

class InfaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfaqController>(
      () => InfaqController(),
    );
  }
}
