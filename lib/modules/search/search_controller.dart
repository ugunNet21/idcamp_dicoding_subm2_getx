import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var searchResults = <Restaurant>[].obs;
  final ApiService apiService;

  SearchController({required this.apiService});

  void searchRestaurants(String query) async {
    try {
      final result = await apiService.searchRestaurants(query);
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
                  categories: [], // Assign an empty list for now, you may update this based on your data
                  menus: Menus(foods: [], drinks: []), // Assign empty Menus for now
                  customerReviews: [], // Assign an empty list for now, you may update this based on your data
                ))
            .toList());
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
