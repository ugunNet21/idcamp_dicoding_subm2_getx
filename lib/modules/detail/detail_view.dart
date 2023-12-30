import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.rate_review),
            onPressed: () {
              Get.toNamed(AppRoutes.ADD_REVIEW, arguments: restaurantId)
                  ?.then((result) {
                if (result == true) {
                  controller.fetchRestaurantDetail(restaurantId);
                }
              });
            },
          ),
        ],
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${controller.restaurant.value.pictureId}',
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('Error loading image: $error');
                      return const Text('Error loading image');
                    },
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.restaurant.value.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'City: ${controller.restaurant.value.city}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            Text(
                              controller.restaurant.value.rating.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ExpansionTile(
                  title: Text('Description'),
                  children: [
                    Text(controller.restaurant.value.description),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories: ${controller.restaurant.value.categories.map((category) => category.name).join(', ')}',
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Foods: ${controller.restaurant.value.menus.foods.map((food) => food.name).join(', ')}',
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Drinks: ${controller.restaurant.value.menus.drinks.map((drink) => drink.name).join(', ')}',
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Customer Reviews:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    for (var review
                        in controller.restaurant.value.customerReviews)
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(review.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(review.review),
                              Text('Date: ${review.date}'),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
