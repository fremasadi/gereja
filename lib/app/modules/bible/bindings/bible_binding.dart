import 'package:get/get.dart';

import '../controllers/bible_controller.dart';

class BibleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BibleController>(
      () => BibleController(),
    );
  }
}
