import 'package:get/get.dart';

import 'package:gereja/app/modules/home/controllers/counseling_controller.dart';
import 'package:gereja/app/modules/home/controllers/schedule_controller.dart';
import 'package:gereja/app/modules/home/controllers/seatbooking_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeatbookingController>(
      () => SeatbookingController(),
    );
    Get.put(CounselingController());
    Get.lazyPut<ScheduleController>(
      () => ScheduleController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
