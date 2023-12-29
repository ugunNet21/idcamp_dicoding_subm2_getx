import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<Map<String, dynamic>> fetchData(String endpoint,
      {Map<String, String>? body, String method = 'GET'}) async {
    // Perhatikan bahwa saya menambahkan {Map<String, String>? body, String method = 'GET'} di parameter
    // Ini memberikan nilai default 'GET' untuk method dan memungkinkan body menjadi opsional (nullable).
    try {
      http.Response response;

      if (method == 'GET') {
        response = await http.get(Uri.parse('$baseUrl$endpoint'));
      } else if (method == 'POST') {
        response = await http.post(
          Uri.parse('$baseUrl$endpoint'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );
      } else {
        // Handle other HTTP methods if needed
        throw Exception('Unsupported HTTP method');
      }

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
