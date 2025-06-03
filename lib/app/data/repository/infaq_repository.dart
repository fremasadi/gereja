import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cons_url.dart';
import '../models/infaq_model.dart';

class InfaqRepository {
  final Uri baseInfaqUrl = Uri.parse('$baseUrl/infaq');

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<InfaqModel>> fetchInfaqList() async {
    final token = await _getToken();
    final response = await http.get(
      baseInfaqUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List data = jsonData['data']['data'];
      return data.map((item) => InfaqModel.fromJson(item)).toList();
    } else {
      throw Exception('Gagal memuat data infaq');
    }
  }

  Future<InfaqModel> submitInfaq(Map<String, dynamic> payload) async {
    final token = await _getToken();
    final response = await http.post(
      baseInfaqUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);
      return InfaqModel.fromJson(jsonData['data']);
    } else {
      final jsonData = json.decode(response.body);
      throw Exception(jsonData['message'] ?? 'Gagal mengirim infaq');
    }
  }
}
