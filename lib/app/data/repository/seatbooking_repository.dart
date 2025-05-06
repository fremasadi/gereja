import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gereja/app/data/services/auth_service.dart';

import '../constants/cons_url.dart';

class SeatbookingRepository {
  final AuthService authService = AuthService();

  Future<List<Map<String, dynamic>>> getAvailableSeats({
    required String serviceDate,
  }) async {
    final token = await authService.getToken();
    final url = Uri.parse(
      '$baseUrl/seat-bookings/available-seats?service_date=$serviceDate&worship_service_id=1',
    );

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        return List<Map<String, dynamic>>.from(jsonData['data']);
      } else {
        throw Exception('Gagal memuat data kursi.');
      }
    } else {
      throw Exception('Gagal terhubung ke server.');
    }
  }

  Future<bool> bookSeats({
    required String serviceDate,
    required List<int>
        seatIds, // Changed from seatLabels to directly use seatIds
    String notes = "",
  }) async {
    try {
      final token = await authService.getToken();
      final url = Uri.parse('$baseUrl/seat-bookings');

      // Create booking requests for each seat
      final List<Future<http.Response>> bookingRequests = [];

      for (int seatId in seatIds) {
        // Create payload for booking using the format provided
        final Map<String, dynamic> payload = {
          "worship_service_id": 1,
          "seat_id": seatId,
          "service_date": serviceDate,
        };

        // Add request to list
        bookingRequests.add(http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: json.encode(payload),
        ));
      }

      // Execute all booking requests
      final responses = await Future.wait(bookingRequests);

      // Check if all requests were successful
      for (var response in responses) {
        if (response.statusCode != 200 && response.statusCode != 201) {
          final errorData = json.decode(response.body);
          throw Exception(
              errorData['message'] ?? 'Failed to book one or more seats.');
        }
      }

      return true; // All bookings successful
    } catch (e) {
      print('Error during seat booking: $e');
      throw Exception('Failed to book seats: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMyBookings() async {
    final token = await authService.getToken();
    final url = Uri.parse('$baseUrl/my-bookings');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['success'] == true) {
        return List<Map<String, dynamic>>.from(jsonData['data']);
      } else {
        throw Exception('Gagal memuat daftar booking.');
      }
    } else {
      throw Exception('Gagal terhubung ke server.');
    }
  }
}
