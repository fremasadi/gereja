// File: seatbooking_controller.dart
import 'package:flutter/material.dart';
import 'package:gereja/app/data/repository/seatbooking_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SeatbookingController extends GetxController {
  final SeatbookingRepository repository = SeatbookingRepository();

  var selectedDate = Rxn<DateTime>();
  var seats = <Map<String, dynamic>>[].obs;
  var selectedSeats = <String>[].obs; // RxList of seat labels
  var selectedSeatIds = <int>[].obs; // New: RxList of seat IDs
  var isLoading = false.obs;
  var bookings = <Map<String, dynamic>>[].obs;

  String get formattedSelectedDate {
    if (selectedDate.value == null) return "";
    return DateFormat('EEEE, dd MMMM yyyy').format(selectedDate.value!);
  }

  Future<void> fetchBookings() async {
    try {
      isLoading.value = true;
      final data = await repository.getMyBookings();
      bookings.assignAll(data);
    } catch (e) {
      print('Error fetching bookings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Check if a seat is selected based on its label
  bool isSelected(String? seatLabel) {
    if (seatLabel == null) return false;
    return selectedSeats.contains(seatLabel);
  }

  // Toggle seat selection based on label and store the corresponding ID
  void toggleSeatSelection(String? seatLabel, int? seatId) {
    if (seatLabel == null || seatId == null) return;

    // Make sure we're properly updating the observable lists
    if (selectedSeats.contains(seatLabel)) {
      selectedSeats.remove(seatLabel);
      selectedSeatIds.remove(seatId);
    } else {
      selectedSeats.add(seatLabel);
      selectedSeatIds.add(seatId);
    }

    // Force UI refresh
    selectedSeats.refresh();
    selectedSeatIds.refresh();

    // Print debug info to verify selection is working
  }

  Future<void> pickSundayDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime sunday = now.weekday == DateTime.sunday
        ? now
        : now.add(Duration(days: (7 - now.weekday) % 7));

    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value ?? sunday,
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      // Allow booking 3 months ahead
      selectableDayPredicate: (DateTime date) {
        // Only allow Sundays
        return date.weekday == DateTime.sunday;
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      selectedSeats.clear();
      selectedSeatIds.clear(); // Clear selected seat IDs as well
      fetchSeats();
    }
  }

  Future<void> fetchSeats() async {
    if (selectedDate.value == null) return;

    isLoading.value = true;
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);

    try {
      final data = await repository.getAvailableSeats(
        serviceDate: formattedDate,
      );
      seats.assignAll(data);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch seats: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> bookSelectedSeats() async {
    if (selectedSeatIds.isEmpty) {
      Get.snackbar(
        "Warning",
        "Please select at least one seat to book",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.yellow[100],
        colorText: Colors.yellow[900],
      );
      return;
    }

    isLoading.value = true;
    final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate.value!);

    try {
      await repository.bookSeats(
        serviceDate: formattedDate,
        seatIds: selectedSeatIds.toList(), // Use the seat IDs list
      );

      Get.snackbar(
        "Success",
        "Successfully booked ${selectedSeats.length} seats",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );

      // Clear selections
      selectedSeats.clear();
      selectedSeatIds.clear();

      // Refresh seat data
      fetchSeats();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to book seats: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Set default date to next Sunday
    final now = DateTime.now();
    if (now.weekday == DateTime.sunday) {
      selectedDate.value = now;
    } else {
      final daysUntilSunday = (7 - now.weekday) % 7;
      selectedDate.value = now.add(Duration(days: daysUntilSunday));
    }
    fetchSeats();
    fetchBookings();
  }
}
