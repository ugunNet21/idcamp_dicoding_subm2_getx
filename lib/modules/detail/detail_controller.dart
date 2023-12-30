import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';

class DetailController extends GetxController {
  final ApiService apiService;

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

  void fetchRestaurantDetail(String restaurantId) async {
    try {
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
        // restaurant(fetchedRestaurant);
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
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
}