import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repository/infaq_repository.dart';

class AddInfaqController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final amountController = TextEditingController();
  final messageController = TextEditingController();

  final isAnonymous = false.obs;
  final selectedType = 'infaq'.obs;

  final types = ['infaq', 'sedekah', 'zakat', 'pembangunan', 'lainnya'];

  final _repo = InfaqRepository();

  void submitDonation() async {
    if (!formKey.currentState!.validate()) return;

    final payload = {
      "donor_name": nameController.text,
      "donor_email": emailController.text,
      "donor_phone": phoneController.text,
      "amount": double.tryParse(amountController.text) ?? 0,
      "type": selectedType.value,
      "message": messageController.text,
      "is_anonymous": isAnonymous.value ? 1 : 0,
    };

    try {
      await _repo.submitInfaq(payload);
      Get.back();
      Get.snackbar('Sukses', 'Donasi berhasil dikirim');
    } catch (e) {
      Get.snackbar('Gagal', e.toString(),
          backgroundColor: Colors.red.withOpacity(0.2));
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    amountController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
