import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';
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

  void loadFavoriteRestaurants() async {
    try {
      isLoading(true);
      error('');
      await Future.delayed(const Duration(seconds: 2));
      final List<Restaurant> favorites =
          _storage.read<List<Restaurant>>(_localFavoritesKey) ?? [];
      favoriteRestaurants.assignAll(favorites);
    } catch (e) {
      error("Error loading favorite restaurants: $e");
    } finally {
      isLoading(false);
    }
  }

  FavoriteController({required this.apiService});

  Future<void> removeFromFavorites(Restaurant restaurant) async {
    try {
      isLoading(true);
      error('');
      final List<Restaurant> favorites =
          _storage.read(_localFavoritesKey) ?? [];
      favorites.removeWhere((fav) => fav.id == restaurant.id);
      await Future.delayed(const Duration(seconds: 1));
      await _storage.write(_localFavoritesKey, favorites);
      Get.snackbar(
          'Removed from Favorites', 'Restaurant removed from your favorites');
      update();
    } catch (e) {
      error("Error removing from favorite: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addToFavorites(Restaurant restaurant) async {
    try {
      isLoading(true);
      error('');
      if (!isRestaurantFavorite(restaurant)) {
        favoriteRestaurants.add(restaurant);
        _storage.write(_localFavoritesKey, favoriteRestaurants);
        Get.snackbar(
            'Added to Favorites', 'Restaurant added to your Favorites');
        update();
      }
    } catch (e) {
      error("Could not add the restaurant to your favorites: $e");
    } finally {
      isLoading(false);
    }
  }

  bool isRestaurantFavorite(Restaurant restaurant) {
    final List<Restaurant> favorites = _storage.read(_localFavoritesKey) ?? [];
    return favorites.any((fav) => fav.id == restaurant.id);
  }
}
