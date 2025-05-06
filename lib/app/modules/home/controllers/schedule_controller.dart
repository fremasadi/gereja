import 'package:get/get.dart';
import '../../../data/repository/schedule_repository.dart';

class ScheduleController extends GetxController {
  var schedules = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      final data = await ScheduleRepository().getSchedules();
      schedules.assignAll(data);
    } catch (e) {
      print('Failed to fetch schedules: $e');
    }
  }
}
