import 'package:get/get.dart';
import '../../../data/repository/marriage_repository.dart';

class MarriageController extends GetxController {
  final MarriageRepository repo = MarriageRepository();

  var marriages = <dynamic>[].obs;
  var isLoading = false.obs;

  Future<void> fetchMarriages() async {
    isLoading.value = true;
    final data = await repo.getMarriages();
    if (data != null) {
      marriages.value = data;
    }
    isLoading.value = false;
  }

  Future<Map<String, dynamic>?> getMarriageDetail(int id) async {
    return await repo.getMarriageDetail(id);
  }

  @override
  void onInit() {
    super.onInit();
    fetchMarriages();
  }
}
