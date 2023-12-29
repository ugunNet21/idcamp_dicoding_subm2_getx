import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<Map<String, dynamic>> fetchData(String endpoint,
      {Map<String, String>? body, String method = 'GET'}) async {
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

  Future<Map<String, dynamic>> searchRestaurants(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));

    if (response.statusCode == 200) {
      return {'error': false, 'restaurants': response.body};
    } else {
      return {'error': true, 'message': 'Failed to search restaurants'};
    }
  }

  Future<Map<String, dynamic>> getRestaurantDetail(String restaurantId) async {
    try {
      final result = await fetchData('/detail/$restaurantId');
      return result;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
