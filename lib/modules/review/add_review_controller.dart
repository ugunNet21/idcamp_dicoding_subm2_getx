import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_view.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';

// class AddReviewController extends GetxController {
//   final ApiService apiService;

//   AddReviewController({required this.apiService});

//   Future<void> addReview(
//       String restaurantId, String name, String review) async {
//     try {
//       final Map<String, String> body = {
//         'id': restaurantId,
//         'name': name,
//         'review': review
//       };
//       final result =
//           await apiService.fetchData('/review', body: body, method: 'POST');

//       if (!result['error']) {
//         _showSnackbar('Review added successfully');
//         Get.back(result: true);
//       }
//     } catch (e) {
//       print('Error: $e');
//       _showSnackbar('Failed to add review');
//     }
//   }

//   void _showSnackbar(String message) {
//     Get.snackbar('Review Status', message);
//   }
// }

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
        print('Review added successfully');
        _showSnackbar('Review added successfully');

        // Kembali ke halaman DetailView setelah berhasil menambahkan review
        Get.offUntil(
          GetPageRoute(
            page: () => DetailView(),
          ),
          ModalRoute.withName(AppRoutes.HOME),
        );
      }
    } catch (e) {
      print('Error: $e');
      _showSnackbar('Failed to add review');
    }
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      'Review Status',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16.0),
    );
  }
}



  // Future<void> addReview(
  //     String restaurantId, String name, String review) async {
  //   try {
  //     final Map<String, String> body = {
  //       'id': restaurantId,
  //       'name': name,
  //       'review': review
  //     };
  //     final result =
  //         await apiService.fetchData('/review', body: body, method: 'POST');

  //     if (!result['error']) {
  //       // Handle success
  //       print('Review added successfully');

  //       // Navigate back to detail page
  //       Get.back();

  //       // Show success message using snackbar
  //       scaffoldKey.currentState?.showSnackBar(
  //         SnackBar(
  //           content: Text('Review added successfully'),
  //           duration: Duration(seconds: 2),
  //         ),
  //       );
  //     } else {
  //       throw Exception(result['message'] ?? 'Failed to add review');
  //     }
  //   } catch (e) {
  //     // Show error message using snackbar
  //     scaffoldKey.currentState?.showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to add review'),
  //         duration: Duration(seconds: 2),
  //       ),
  //     );
  //     print('Error adding review: $e');
  //   }
  // }

  // Future<void> addReview(
  //     String restaurantId, String name, String review) async {
  //   try {
  //     final result = await apiService.addReview(restaurantId, name, review);
  //     if (!result['error']) {
  //       // Handle success
  //       print('Review added successfully');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }