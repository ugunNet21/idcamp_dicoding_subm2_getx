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
        throw Exception('Unsupported HTTP method');
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data: Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> searchRestaurants(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/search?q=$query'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> restaurantsData = responseData['restaurants'];
        if (restaurantsData.isEmpty) {
          return {'error': true, 'message': 'Restaurants not found'};
        }
        final List<Map<String, dynamic>> mappedRestaurants = restaurantsData
            .map((data) => {
                  'id': data['id'],
                  'name': data['name'],
                  'description': data['description'],
                  'pictureId': data['pictureId'],
                  'city': data['city'],
                  'rating': data['rating'],
                })
            .toList();
        return {'error': false, 'restaurants': mappedRestaurants};
      } else {
        throw Exception('Failed to search restaurants. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
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

  Future<Map<String, dynamic>> addReview(
      String restaurantId, String name, String review) async {
    try {
      final Map<String, String> body = {
        'id': restaurantId,
        'name': name,
        'review': review
      };
      final response = await http.post(
        Uri.parse('$baseUrl/review'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to add review. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> getRandomRestaurants() async {
    try {
      final response = await fetchData('/list');

      if (response['restaurants'] != null) {
        final List<dynamic> restaurantsData = response['restaurants'];
        final List<Map<String, dynamic>> mappedRestaurants = restaurantsData
            .map((data) => {
                  'id': data['id'],
                  'name': data['name'],
                  'description': data['description'],
                  'pictureId': data['pictureId'],
                  'city': data['city'],
                  'rating': data['rating'],
                })
            .toList();
        return {'error': false, 'restaurants': mappedRestaurants};
      } else {
        throw Exception('Failed to get random restaurants');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}