
import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = controller.restaurants[index];
            return ListTile(
              title: Text(restaurant.name),
              subtitle: Text(restaurant.description),
              // Other UI components based on restaurant data
            );
          },
        ),
      ),
    );
  }
}