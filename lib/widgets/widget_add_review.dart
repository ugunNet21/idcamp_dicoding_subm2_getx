import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewDialog extends StatelessWidget {
  final Function(String, String) onAddReview;

  const AddReviewDialog({Key? key, required this.onAddReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Review'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
            // ...
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Review'),
            // ...
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Panggil callback untuk menambah review
            onAddReview('nameValue', 'reviewValue');
          },
          child: const Text('Add Review'),
        ),
      ],
    );
  }
}
