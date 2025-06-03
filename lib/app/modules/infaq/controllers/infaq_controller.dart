import 'package:get/get.dart';
import '../../../data/models/infaq_model.dart';
import '../../../data/repository/infaq_repository.dart';

class InfaqController extends GetxController {
  final InfaqRepository _repository = InfaqRepository();

  var infaqList = <InfaqModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInfaq();
  }

  void fetchInfaq() async {
    try {
      isLoading.value = true;
      final data = await _repository.fetchInfaqList();
      infaqList.assignAll(data);
    } catch (e) {
      print(e.toString());
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendInfaq(Map<String, dynamic> payload) async {
    try {
      isLoading.value = true;
      final result = await _repository.submitInfaq(payload);
      infaqList.insert(0, result);
      Get.snackbar("Sukses", "Donasi berhasil dibuat.");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
