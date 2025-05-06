import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/repository/counseling_repository.dart';
import '../views/counseling_view.dart';

class CounselingController extends GetxController {
  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Text controllers - declared but not initialized
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController topicController;

  // Reactive counseling type dropdown
  final Rx<String?> selectedType = Rx<String?>(null);

  // Observable variables
  final gender = 'female'.obs;
  final genderError = ''.obs;
  final selectedDate = DateTime.now().obs;
  final dateError = ''.obs;
  final isLoading = false.obs;

  // Repository
  final repo = CounselingRepository();

  // Flag to track if controller is active
  bool _isActive = false;

  @override
  void onInit() {
    super.onInit();
    _initControllers();
  }

  void _initControllers() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    ageController = TextEditingController();
    topicController = TextEditingController();
    _isActive = true;
  }

  @override
  void onClose() {
    _disposeControllers();
    super.onClose();
  }

  void _disposeControllers() {
    if (_isActive) {
      nameController.dispose();
      phoneController.dispose();
      ageController.dispose();
      topicController.dispose();
      _isActive = false;
    }
  }

  // Validate all fields including gender and date
  bool validateAll() {
    if (!_isActive) return false;

    bool isFormValid = formKey.currentState!.validate();

    // Validate gender selection
    if (gender.value.isEmpty) {
      genderError.value = 'Please select your gender';
      isFormValid = false;
    } else {
      genderError.value = '';
    }

    // Validate if date is selected properly
    // Ensure the date is not in the past
    if (selectedDate.value
        .isBefore(DateTime.now().subtract(const Duration(days: 1)))) {
      dateError.value = 'Please select a valid date';
      isFormValid = false;
    } else {
      dateError.value = '';
    }

    return isFormValid;
  }

  // Submit counseling request with validation
  Future<void> submitCounseling() async {
    // Validate all fields first
    if (!validateAll()) {
      Get.snackbar(
        'Validation Error',
        'Silakan periksa kembali semua field',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      isLoading.value = true;

      // Capture all values before potentially losing controllers
      final name = nameController.text.trim();
      final phone = phoneController.text.trim();
      final currentGender = gender.value;
      final date = selectedDate.value.toIso8601String().split('T').first;
      final age = int.tryParse(ageController.text.trim()) ?? 0;
      final topic = topicController.text.trim();
      final type = selectedType.value;

      // Using the original repository call with captured values
      await repo.createCounseling(
        name: name,
        phone: phone,
        gender: currentGender,
        date: date,
        age: age,
        counselingTopic: topic,
        type: type!,
      );

      // Navigate to success screen
      Get.to(() => CounselingSuccess());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Safe reset method to be called from success screen
  void resetForm() {
    if (!_isActive) {
      // Re-initialize controllers if they were disposed
      _initControllers();
    }

    clearForm();
  }

  // Updated clear form method
  void clearForm() {
    if (_isActive) {
      nameController.clear();
      phoneController.clear();
      ageController.clear();
      topicController.clear();
    }

    selectedType.value = null; // Reset the dropdown value
    gender.value = 'female';
    selectedDate.value = DateTime.now();

    // Clear any validation errors
    genderError.value = '';
    dateError.value = '';
  }
}
