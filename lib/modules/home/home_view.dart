import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:flutter_subm2_getx/modules/navigation/bottom_nav_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
// ignore: depend_on_referenced_packages
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
          style: orangeTextStyle.copyWith(fontSize: 18, fontWeight: bold),
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
                title: Text(restaurant.name,
                    style: blackTextStyle.copyWith(
                        fontSize: 14, fontWeight: bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('City: ${restaurant.city}',
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium)),
                    Text('Rating: ${restaurant.rating.toString()}',
                        style: blackTextStyle.copyWith(
                            fontSize: 12, fontWeight: medium)),
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
