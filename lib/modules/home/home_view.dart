import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:flutter_subm2_getx/modules/navigation/bottom_nav_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find();
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurant List',
          style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await Get.toNamed(AppRoutes.search);
              controller.fetchData();
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Obx(
            () => _buildContent(context, controller),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, HomeController controller) {
    if (controller.isLoading.value) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('There is an error. Check internet connection'),
            ElevatedButton(
              onPressed: () {
                controller.setError('');
                controller.fetchData();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    } else if (controller.restaurants.isEmpty) {
      return const Center(
        child: Text('No restaurants available.'),
      );
    } else {
      return RefreshIndicator(
        onRefresh: () async {
          await controller.fetchData();
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          itemCount: controller.restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = controller.restaurants[index];
            return GestureDetector(
              onTap: () {
                // Handle ontap action here, for example:
                controller.navigateToDetail(restaurant.id);
              },
              child: SingleChildScrollView(
                child: Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(
                          restaurant.name,
                          style: blackTextStyle.copyWith(
                            fontSize: 14,
                            fontWeight: bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                Text(
                                  ' ${restaurant.rating.toString()}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: medium,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'City: ${restaurant.city}',
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              controller.navigateToDetail(restaurant.id);
                            },
                            icon: const Icon(Icons.visibility),
                            label: const Text('See Details'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
