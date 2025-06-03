import 'package:get/get.dart';

import '../controllers/add_marriage_controller.dart';

class AddMarriageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMarriageController>(
      () => AddMarriageController(),
    );
  }
}
