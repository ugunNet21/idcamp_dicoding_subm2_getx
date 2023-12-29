import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final ApiService apiService;
  var searchResults = <Restaurant>[].obs;

  SearchController({required this.apiService});

  Future<void> searchRestaurants(String query) async {
    try {
      final result = await apiService.fetchData('/search?q=$query');
      if (!result['error']) {
        final List<dynamic> restaurantData = result['restaurants'];
        searchResults.assignAll(restaurantData
            .map((data) => Restaurant(
                  id: data['id'],
                  name: data['name'],
                  description: data['description'],
                  pictureId: data['pictureId'],
                  city: data['city'],
                  rating: data['rating'].toDouble(),
                ))
            .toList());
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}