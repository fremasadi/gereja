import 'package:get/get.dart';

import '../controllers/add_infaq_controller.dart';

class AddInfaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInfaqController>(
      () => AddInfaqController(),
    );
  }
}
