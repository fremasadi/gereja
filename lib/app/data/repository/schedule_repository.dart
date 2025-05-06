import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cons_url.dart';

class ScheduleRepository {
  /// Mendapatkan daftar jadwal gereja
  Future<List<Map<String, dynamic>>> getSchedules() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token tidak tersedia. Pengguna belum login.");
    }

    final url = Uri.parse('$baseUrl/church-events');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Gagal mengambil data jadwal: ${response.body}');
    }
  }
}
