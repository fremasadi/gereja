import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/cons_url.dart';

class CounselingRepository {
  /// Post new counseling data
  Future<void> createCounseling({
    required String name,
    required String phone,
    required String gender,
    required String date,
    required int age,
    required String counselingTopic,
    required String type,
  }) async {
    final url = Uri.parse('$baseUrl/counselings');

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login terlebih dahulu.');
    }

    final body = {
      "name": name,
      "phone": phone,
      "gender": gender,
      "date": date,
      "age": age,
      "counseling_topic": counselingTopic,
      "type": type,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      // Berhasil
      return;
    } else {
      throw Exception('Gagal mengirim data konseling: ${response.body}');
    }
  }
}
