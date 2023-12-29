import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService apiService;
  var restaurants = <Restaurant>[].obs;

  HomeController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await apiService.fetchData('/list');
      if (!result['error']) {
        final List<dynamic> restaurantData = result['restaurants'];
        restaurants.assignAll(restaurantData
            .map((data) => Restaurant(
                  id: data['id'],
                  name: data['name'],
                  description: data['description'],
                  pictureId: data['pictureId'],
                  city: data['city'],
                  rating: data['rating'].toDouble(),
                  categories: [],
                  menus: Menus(foods: [], drinks: []),
                  customerReviews: [],
                ))
            .toList());
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void navigateToDetail(String restaurantId) {
    Get.toNamed(AppRoutes.DETAIL, arguments: restaurantId);
  }
}
