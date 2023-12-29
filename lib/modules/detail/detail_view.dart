
import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_controller.dart';
import 'package:get/get.dart';

class DetailView extends StatelessWidget {
  final DetailController controller = Get.find();
  final String restaurantId = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    final String restaurantId = Get.arguments;
    controller.fetchRestaurantDetail(restaurantId);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.restaurant.value.name)),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display restaurant details here
              Text('Description: ${controller.restaurant.value.description}'),
              Text('City: ${controller.restaurant.value.city}'),
              // Add other details as needed

              // Display categories
              Text('Categories: ${controller.restaurant.value.categories.map((category) => category.name).join(', ')}'),

              // Display menus
              Text('Foods: ${controller.restaurant.value.menus.foods.map((food) => food.name).join(', ')}'),
              Text('Drinks: ${controller.restaurant.value.menus.drinks.map((drink) => drink.name).join(', ')}'),

              // Display customer reviews
              Text('Customer Reviews:'),
              for (var review in controller.restaurant.value.customerReviews)
                Text('${review.name} says: ${review.review} on ${review.date}'),
            ],
            // children: [
            //   Image.network(
            //     'https://restaurant-api.dicoding.dev/images/medium/${controller.restaurant.value.pictureId}',
            //     height: 200,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       controller.restaurant.value.name,
            //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(controller.restaurant.value.description),
            //   ),
            //   // Other UI components based on restaurant detail data
            // ],
          ),
        ),
      ),
    );
  }
}