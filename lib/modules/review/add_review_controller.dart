import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class AddReviewController extends GetxController {
  final ApiService apiService;

  AddReviewController({required this.apiService});

  Future<void> addReview(String restaurantId, String name, String review) async {
    try {
      final Map<String, String> body = {'id': restaurantId, 'name': name, 'review': review};
      final result = await apiService.fetchData('/review', body: body, method: 'POST');
      if (!result['error']) {
        // Handle success
        print('Review added successfully');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}