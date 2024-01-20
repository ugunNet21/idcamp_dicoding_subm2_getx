import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/modules/favorite/favorite_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';

class FavoriteView extends StatelessWidget {
  final FavoriteController controller = Get.find();

  FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite Restaurants',
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
      ),
      body: Obx(
        () {
          final List<Restaurant> favorites = controller.favoriteRestaurants;

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorite restaurants yet!',
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final restaurant = favorites[index];
              return ListTile(
                title: Text(restaurant.name),
                subtitle: Text(restaurant.city),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    controller.removeFromFavorites(restaurant);
                  },
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.detail, arguments: restaurant.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
