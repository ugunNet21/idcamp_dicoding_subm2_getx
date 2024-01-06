import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService apiService;
  var isLoading = true.obs;
  var error = ''.obs;
  var restaurant = Restaurant(
          id: '',
          name: '',
          description: '',
          pictureId: '',
          city: '',
          rating: 0.0,
          categories: <Category>[].obs,
          menus: Menus(foods: <Food>[].obs, drinks: <Drink>[].obs),
          customerReviews: <CustomerReview>[].obs,
          address: '')
      .obs;

  DetailController({required this.apiService});

  @override
  void onInit() {
    super.onInit();
    final String restaurantId = Get.arguments as String;
    fetchRestaurantDetail(restaurantId);
  }

  void setError(String errorMessage) {
    error(errorMessage);
  }

  Future<void> fetchRestaurantDetail(String restaurantId) async {
    try {
      isLoading(true);
      error('');
      reviewAdded.value = false;
      // print('Fetching detail for restaurant with ID: $restaurantId');
      final result = await apiService.getRestaurantDetail(restaurantId);
      if (!result['error']) {
        final Map<String, dynamic> restaurantData = result['restaurant'];
        restaurant(Restaurant.fromJson(restaurantData));
      } else {
        setError('Failed to load restaurant detail');
      }
    } catch (e) {
      // print('Error fetching restaurant detail: $e');
      setError(e.toString());
    } finally {
      isLoading(false);
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
}
