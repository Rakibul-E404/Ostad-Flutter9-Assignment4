import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://35.73.30.144:2005/api/v1";

  Future<dynamic> post(String endpoint, dynamic body, {String? token}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> get(String endpoint, {String? token}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic body, {String? token}) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint, {String? token}) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}