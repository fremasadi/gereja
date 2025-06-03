import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cons_url.dart';

class MarriageRepository {
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<List<dynamic>?> getMarriages() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/marriages');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // handle error
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMarriageDetail(int id) async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/marriages/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // handle error
      return null;
    }
  }

  Future<bool> createMarriage(Map<String, dynamic> data) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/marriages');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );

    return response.statusCode == 201;
  }
}
