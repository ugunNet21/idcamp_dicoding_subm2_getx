
import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_controller.dart';
import 'package:get/get.dart';

class AddReviewView extends StatelessWidget {
  final AddReviewController controller = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String restaurantId = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              controller: reviewController,
              decoration: InputDecoration(labelText: 'Your Review'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                controller.addReview(restaurantId, nameController.text, reviewController.text);
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}