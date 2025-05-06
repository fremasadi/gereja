import 'package:gereja/app/modules/home/controllers/home_controller.dart';
import 'package:gereja/app/modules/home/controllers/seatbooking_controller.dart';
import 'package:get/get.dart';

import '../../home/controllers/counseling_controller.dart';
import '../../home/controllers/schedule_controller.dart';
import '../controllers/base_controller.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BaseController>(
      () => BaseController(),
    );
    Get.put(HomeController());
    Get.put(ScheduleController());
    Get.lazyPut<CounselingController>(
      () => CounselingController(),
      fenix: true, // This recreates the controller when needed
    );
    Get.put(SeatbookingController());
  }
}
