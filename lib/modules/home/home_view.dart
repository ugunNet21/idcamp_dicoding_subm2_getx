import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await Get.toNamed(AppRoutes.SEARCH);
              // Setelah kembali dari SearchView, panggil fetchData untuk memperbarui data
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
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.error.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('There is an error. check internet connection'),
            ElevatedButton(
              onPressed: () {
                // Set error ke empty string dan panggil fetchData
                controller.setError('');
                controller.fetchData();
              },
              child: Text('Try Again'),
            ),
          ],
        ),
      );
    } else if (controller.restaurants.isEmpty) {
      return Center(
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
