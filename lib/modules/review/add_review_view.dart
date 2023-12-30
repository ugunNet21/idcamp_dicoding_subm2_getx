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
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: reviewController,
              decoration: InputDecoration(labelText: 'Your Review'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    reviewController.text.isEmpty) {
                  // Menampilkan pesan kesalahan jika ada field yang kosong
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
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}


// class AddReviewView extends StatelessWidget {
//   final AddReviewController controller = Get.find();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController reviewController = TextEditingController();
//   final GlobalKey<ScaffoldMessengerState> scaffoldKey =
//       GlobalKey<ScaffoldMessengerState>();

//   @override
//   Widget build(BuildContext context) {
//     final String restaurantId = Get.arguments;

//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: Text('Add Review'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Your Name'),
//             ),
//             TextField(
//               controller: reviewController,
//               decoration: InputDecoration(labelText: 'Your Review'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () async {
//                 await controller.addReview(
//                   restaurantId,
//                   nameController.text,
//                   reviewController.text,
//                 );
//                 Get.back(result: true);
//               },
//               child: Text('Submit Review'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

            // ElevatedButton(
            //   onPressed: () {
            //     controller.addReview(
            //       restaurantId,
            //       nameController.text,
            //       reviewController.text,
            //     );
            //   },
            //   child: Text('Submit Review'),
            // ),