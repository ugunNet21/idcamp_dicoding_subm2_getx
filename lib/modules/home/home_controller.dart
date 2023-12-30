import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ApiService apiService;
  var isLoading = true.obs;
  var error = ''.obs;
  var restaurants = <Restaurant>[].obs;

  HomeController({required this.apiService});
   void showSnackbarError(String errorMessage) {
    Get.snackbar(
      'Try Again',
      errorMessage,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.0),
    );
  }

  void setError(String errorMessage) {
    error(errorMessage);
    showSnackbarError(errorMessage);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      isLoading(true);
      error('');
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
      error(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void navigateToDetail(String restaurantId) {
    Get.toNamed(AppRoutes.DETAIL, arguments: restaurantId);
  }
}
