import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var searchResults = <Restaurant>[].obs;
  final ApiService apiService;
  var isLoading = false.obs;
  var error = ''.obs;

  SearchController({required this.apiService});
  void setError(String errorMessage) {
    error(errorMessage);
  }

  Future<void> searchRestaurants(String query) async {
    try {
      isLoading(true);
      error('');
      if (!await checkInternetConnection()) {
        showSnackbarInfo('No internet connection.');
        return;
      }

      if (query.isEmpty) {
        searchResults.clear();
        return;
      }

      final result = await apiService.searchRestaurants(query);
      if (result['error']) {
        debugPrint('Error: ${result['message']}');
        showSnackbarError('Please try another search again.');
        return;
      }

      final List<dynamic> restaurantData = result['restaurants'];
      if (restaurantData.isEmpty) {
        debugPrint('No matching restaurants found');
        showSnackbarInfo('No matching restaurants found.');
        return;
      }

      searchResults.assignAll(restaurantData
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
                address: '',
              ))
          .toList());
    } catch (e) {
      debugPrint('Search error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void navigateToDetail(String restaurantId) {
    Get.toNamed(AppRoutes.detail, arguments: restaurantId);
  }

  void showSnackbarError(String errorMessage) {
    Get.snackbar(
      'Error',
      errorMessage,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16.0),
    );
  }

  void showSnackbarInfo(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16.0),
    );
  }
}
