import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';

class AddReviewController extends GetxController {
  final ApiService apiService;

  AddReviewController({
    required this.apiService,
  });

  Future<void> addReview(
      String restaurantId, String name, String review) async {
    try {
      final Map<String, String> body = {
        'id': restaurantId,
        'name': name,
        'review': review,
      };
      final result =
          await apiService.fetchData('/review', body: body, method: 'POST');

      if (!result['error']) {
        debugPrint('Review added successfully');
        Get.showSnackbar(
          GetSnackBar(
            message: 'Review added successfully',
            duration: Duration(seconds: 20),
          ),
        );
        Get.until((route) => Get.currentRoute == AppRoutes.home);
      }
    } catch (e) {
      debugPrint('Error: $e');
      Get.showSnackbar(
        GetSnackBar(
          message: 'Failed to add review',
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

  // void _showSnackbar(String message) {
  //   print('Showing Snackbar: $message');
  //   Get.rawSnackbar(
  //     messageText: Text(message),
  //     snackPosition: SnackPosition.BOTTOM,
  //     margin: const EdgeInsets.all(16.0),
  //   );
  // }