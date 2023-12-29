
import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_controller.dart';
import 'package:get/get.dart';

class DetailView extends StatelessWidget {
  final DetailController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final String restaurantId = Get.arguments;
    controller.fetchDetail(restaurantId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Detail'),
      ),
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${controller.restaurant.value.pictureId}',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.restaurant.value.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(controller.restaurant.value.description),
            ),
            // Other UI components based on restaurant detail data
          ],
        ),
      ),
    );
  }
}