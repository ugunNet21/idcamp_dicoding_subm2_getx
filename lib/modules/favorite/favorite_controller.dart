import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class FavoriteController extends GetxController {
  final ApiService apiService;
  final _storage = GetStorage();
  final _localFavoritesKey = 'localFavorites';
  RxList<Restaurant> favoriteRestaurants = <Restaurant>[].obs;

  var isLoading = true.obs;
  var error = ''.obs;
  @override
  void onInit() {
    super.onInit();
    loadFavoriteRestaurants();
  }

  void loadFavoriteRestaurants() {
    final List<Restaurant> favorites =
        _storage.read<List<Restaurant>>(_localFavoritesKey) ?? [];
    favoriteRestaurants.assignAll(favorites);
  }

  FavoriteController({required this.apiService});

  Future<void> removeFromFavorites(Restaurant restaurant) async {
    try {
      final List<Restaurant> favorites =
          _storage.read(_localFavoritesKey) ?? [];
      favorites.removeWhere((fav) => fav.id == restaurant.id);

      await _storage.write(_localFavoritesKey, favorites);
      Get.snackbar(
          'Removed from Favorites', 'Restaurant removed from your favorites');
      update();
    } catch (e) {
      error("Error removing from favorite");
    }
  }

  Future<void> addToFavorites(Restaurant restaurant) async {
    if (!isRestaurantFavorite(restaurant)) {
      favoriteRestaurants.add(restaurant);
      _storage.write(_localFavoritesKey, favoriteRestaurants);
      Get.snackbar('Added to Favorites', 'Restaurant added to your Favorites');
      update();
    }
  }

  bool isRestaurantFavorite(Restaurant restaurant) {
    final List<Restaurant> favorites = _storage.read(_localFavoritesKey) ?? [];
    return favorites.any((fav) => fav.id == restaurant.id);
  }
}
