import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService apiService;
  var restaurant = Restaurant(id: '', name: '', description: '', pictureId: '', city: '', rating: 0.0).obs;

  DetailController({required this.apiService});

  Future<void> fetchDetail(String restaurantId) async {
    try {
      final result = await apiService.fetchData('/detail/$restaurantId');
      if (!result['error']) {
        final Map<String, dynamic> restaurantData = result['restaurant'];
        restaurant.value = Restaurant(
          id: restaurantData['id'],
          name: restaurantData['name'],
          description: restaurantData['description'],
          pictureId: restaurantData['pictureId'],
          city: restaurantData['city'],
          rating: restaurantData['rating'].toDouble(),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}