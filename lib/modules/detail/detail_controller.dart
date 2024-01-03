import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService apiService;
  var isLoading = true.obs;
  var error = ''.obs;
  void showSnackbarError(String errorMessage) {
    Get.snackbar(
      'Try Again',
      errorMessage,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16.0),
    );
  }

  void setError(String errorMessage) {
    error(errorMessage);
    showSnackbarError(errorMessage);
  }

  DetailController({required this.apiService});
  final Rx<Restaurant> restaurant = Rx<Restaurant>(Restaurant(
    id: '',
    name: '',
    description: '',
    city: '',
    pictureId: '',
    rating: 0.0,
    categories: [],
    menus: Menus(foods: [], drinks: []),
    customerReviews: [],
  ));

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    try {
      isLoading(true);
      error('');
      reviewAdded.value = false;
      final result = await apiService.getRestaurantDetail(restaurantId);
      if (!result['error']) {
        final Map<String, dynamic> restaurantData = result['restaurant'];
        final Restaurant fetchedRestaurant = Restaurant(
          id: restaurantData['id'],
          name: restaurantData['name'],
          description: restaurantData['description'],
          city: restaurantData['city'],
          pictureId: restaurantData['pictureId'],
          rating: restaurantData['rating'].toDouble(),
          categories: List<Category>.from(restaurantData['categories']
              .map((category) => Category(name: category['name']))),
          menus: Menus(
            foods: List<Food>.from(restaurantData['menus']['foods']
                .map((food) => Food(name: food['name']))),
            drinks: List<Drink>.from(restaurantData['menus']['drinks']
                .map((drink) => Drink(name: drink['name']))),
          ),
          customerReviews: List<CustomerReview>.from(
              restaurantData['customerReviews'].map((review) => CustomerReview(
                    name: review['name'],
                    review: review['review'],
                    date: review['date'],
                  ))),
        );
        restaurant.value = fetchedRestaurant;
      } else {
        isLoading(false);
        setError('Failed to load data. Check your internet connection.');
        reviewAdded.value = false;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
      setError('Failed to load data');
      reviewAdded.value = false;
      isLoading(false);
      setError('Failed to load data. Check your internet connection.');
      reviewAdded.value = false;
      // ignore: avoid_print
      print('Error in fetchRestaurantDetail: $e');
    } finally {
      isLoading(false);
      update();
    }
  }

  final RxBool reviewAdded = RxBool(false);
  Future<void> addReview(
      String restaurantId, String name, String review) async {
    try {
      final result = await apiService.addReview(restaurantId, name, review);
      if (!result['error']) {
        reviewAdded.value = true;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error adding review: $e');
    }
  }

  void resetReviewAdded() {
    reviewAdded.value = false;
  }

  // ignore: unused_element
  Future<void> _refresh() async {
    try {
      isLoading(true);
      error('');
      await fetchRestaurantDetail(restaurant.value.id);
    } catch (e) {
      debugPrint('Error in _refresh: $e');
    } finally {
      isLoading(false);
    }
  }
}
