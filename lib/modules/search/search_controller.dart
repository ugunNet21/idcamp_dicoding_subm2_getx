import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var searchResults = <Restaurant>[].obs;
  final ApiService apiService;
   var error = ''.obs;

  SearchController({required this.apiService});
  void setError(String errorMessage) {
    error(errorMessage);
    // showSnackbarError(errorMessage);
  }

  void searchRestaurants(String query) async {
    try {
      error('');
      if (!await checkInternetConnection()) {
        showSnackbarInfo('Tidak ada koneksi internet.');
        return;
      }

      if (query.isEmpty) {
        searchResults.clear();
        return;
      }

      final result = await apiService.searchRestaurants(query);
      if (result['error']) {
        // Handle error response
        print('Error: ${result['message']}');
        showSnackbarError('Terjadi kesalahan. Silakan coba lagi.');
        return;
      }

      final List<dynamic> restaurantData = result['restaurants'];
      if (restaurantData.isEmpty) {
        // Handle case when no matching restaurants are found
        print('No matching restaurants found');
        showSnackbarInfo('Tidak ada restoran yang cocok.');
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
              ))
          .toList());
    } catch (e) {
      print('Error: $e');
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
    Get.toNamed(AppRoutes.DETAIL, arguments: restaurantId);
  }

  void showSnackbarError(String errorMessage) {
    Get.snackbar(
      'Error',
      errorMessage,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.0),
    );
  }

  void showSnackbarInfo(String message) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.0),
    );
  }
}