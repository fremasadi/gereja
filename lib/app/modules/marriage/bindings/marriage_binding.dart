import 'package:get/get.dart';

import '../controllers/marriage_controller.dart';

class MarriageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarriageController>(
      () => MarriageController(),
    );
  }
}
