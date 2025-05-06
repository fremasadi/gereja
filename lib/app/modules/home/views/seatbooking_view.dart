// File: seat_booking_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja/app/data/constants/const_color.dart';
import 'package:get/get.dart';
import '../controllers/seatbooking_controller.dart';

class SeatbookingView extends GetView<SeatbookingController> {
  const SeatbookingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Booking'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await controller.fetchBookings();

              Get.bottomSheet(
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (controller.bookings.isEmpty) {
                      return Text("Tidak ada booking.");
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.bookings.length,
                      itemBuilder: (context, index) {
                        final booking = controller.bookings[index];
                        final seat = booking['seat'];
                        final service = booking['worship_service'];

                        return ListTile(
                          title: Text(
                              '${service['name']} - Kursi ${seat['label']}'),
                          subtitle: Text('Kode: ${booking['booking_code']}'),
                          trailing: Text(
                            booking['service_date'].toString().split('T')[0],
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      },
                    );
                  }),
                ),
              );
            },
            icon: Icon(
              Icons.work_history_outlined,
              size: 28.sp,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Date display section
          GestureDetector(
            onTap: () => controller.pickSundayDate(context),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Spacer(),
                  Icon(
                    Icons.calendar_month,
                    color: Colors.red,
                    size: 28.sp,
                  ),
                  SizedBox(width: 8),
                  Obx(() => Text(
                        controller.selectedDate.value != null
                            ? controller.formattedSelectedDate
                            : "Select a Sunday to view available seats",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  Spacer(),
                ],
              ),
            ),
          ),

          // // Notes input field - NEW
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       labelText: 'Notes',
          //       hintText: 'Any special requests? (optional)',
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       filled: true,
          //       fillColor: Colors.grey[100],
          //     ),
          //     maxLines: 2,
          //     onChanged: (value) => controller.setNotes(value),
          //   ),
          // ),

          // Seat legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(Colors.green, "Available"),
                const SizedBox(width: 16),
                _buildLegendItem(Colors.grey, "Booked"),
                const SizedBox(width: 16),
                _buildLegendItem(Colors.blue, "Selected"),
              ],
            ),
          ),

          // Seat grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.selectedDate.value == null) {
                return const Center(
                  child: Text(
                    "Please select a Sunday date",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              if (controller.seats.isEmpty) {
                return const Center(
                  child: Text(
                    "No seat data available for this date.",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.seats.length,
                  itemBuilder: (_, index) {
                    final seat = controller.seats[index];
                    final isBooked = seat['is_booked'] ?? false;
                    final String seatLabel = seat['label'] ?? "?";
                    final int seatId = seat['id'] ?? -1; // Get the seat ID

                    // Using Obx here ensures this specific seat redraws when selection changes
                    return Obx(() {
                      final isSelected =
                          controller.selectedSeats.contains(seatLabel);

                      return GestureDetector(
                        onTap: isBooked
                            ? null
                            : () => controller.toggleSeatSelection(
                                seatLabel, seatId),
                        // Pass both label and ID
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isBooked
                                ? Colors.grey
                                : isSelected
                                    ? Colors.blue
                                    : Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            seatLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    });
                  },
                ),
              );
            }),
          ),

          // Booking action button
          Obx(() => Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: controller.selectedSeats.isEmpty
                      ? null
                      : () => controller.bookSelectedSeats(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: ConstColor.primaryColor,
                  ),
                  child: Text(
                    'Book ${controller.selectedSeats.length} ${controller.selectedSeats.length == 1 ? 'Seat' : 'Seats'}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'SemiBold',
                      color: ConstColor.white,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}
