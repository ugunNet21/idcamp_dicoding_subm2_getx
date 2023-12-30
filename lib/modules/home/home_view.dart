import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find();

   HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
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
            const Text('There is an error. check internet connection'),
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
          // Panggil fetchData untuk memperbarui data
          await controller.fetchData();
        },
        child: ListView.builder(
          itemCount: controller.restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = controller.restaurants[index];
            return Card(
              child: ListTile(
                title: Text(restaurant.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City: ${restaurant.city}'),
                    Text('Rating: ${restaurant.rating.toString()}'),
                  ],
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                onTap: () {
                  controller.navigateToDetail(restaurant.id);
                },
              ),
            );
          },
        ),
      );
    }
  }
}
