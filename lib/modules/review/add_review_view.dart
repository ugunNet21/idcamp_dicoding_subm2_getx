import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/review/add_review_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class AddReviewView extends StatelessWidget {
  final AddReviewController controller = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();

  AddReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final String restaurantId = Get.arguments;

    return GetBuilder<AddReviewController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add Review'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Your Name'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: reviewController,
                  decoration: const InputDecoration(labelText: 'Your Review'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        reviewController.text.isEmpty) {
                      Get.snackbar('Error', 'Please fill in all fields');
                    } else {
                      // Melakukan penambahan ulasan jika tidak ada field yang kosong
                      await controller.addReview(
                        restaurantId,
                        nameController.text,
                        reviewController.text,
                      );
                      Get.back(result: true);
                    }
                  },
                  child: const Text('Submit Review'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
