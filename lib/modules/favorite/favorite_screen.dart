import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/modules/favorite/favorite_controller.dart';
import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:flutter_subm2_getx/modules/navigation/bottom_nav_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';

class FavoriteView extends StatelessWidget {
  final FavoriteController controller = Get.find();
  final HomeController _homeController = Get.find();
  final BottomNavigationController bottomNavigationController =
      Get.put(BottomNavigationController());

  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Restaurants',
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await Get.toNamed(AppRoutes.search);
              _homeController.fetchData();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final List<Restaurant> favorites = controller.favoriteRestaurants;
          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorite restaurants yet!',
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
            );
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final restaurant = favorites[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        restaurant.name,
                        style: blackTextStyle.copyWith(
                            fontSize: 16, fontWeight: bold),
                      ),
                      subtitle: Row(
                        children: [
                          const Icon(
                            Icons.location_city,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.city,
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            restaurant.rating.toString(),
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: medium),
                          ),
                          const SizedBox(width: 4),
                          IconButton(
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              controller.removeFromFavorites(restaurant);
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(AppRoutes.detail, arguments: restaurant.id);
                      },
                    ),
                  );
                },
              ),
            );
          }
        }
      }),
    );
  }
}
