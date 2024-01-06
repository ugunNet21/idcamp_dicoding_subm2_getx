import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/modules/detail/detail_controller.dart';
import 'package:flutter_subm2_getx/routes/app_routes.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';

class DetailView extends StatelessWidget {
  final DetailController controller = Get.find();
  final String restaurantId = Get.arguments;

  DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    // print('Restaurant in DetailView: ${controller.restaurant}');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Restaurant Detail',
          style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.rate_review),
            onPressed: () {
              Get.toNamed(AppRoutes.addReview, arguments: restaurantId);
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load restaurant detail. check internet connections',
                    style: blackTextStyle.copyWith(
                        fontSize: 10, fontWeight: medium),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.setError('');
                      controller.fetchRestaurantDetail(restaurantId);
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          } else {
            return _buildContent(controller.restaurant.value);
          }
        },
      ),
    );
  }

  Widget _buildContent(Restaurant restaurant) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ClipRect(
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Restaurant : ${restaurant.name}',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ExpansionTile(
              title: Text('Description',
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: bold)),
              children: [
                Text(
                  controller.restaurant.value.description,
                  style:
                      blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          // Text('Description: ${restaurant.description}'),
          const SizedBox(height: 16),
          Text(
            'City: ${restaurant.city}',
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium),
          ),
          const SizedBox(height: 16),
          Text('Address: ${restaurant.address}',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          const SizedBox(height: 16),
          Text('Rating: ${restaurant.rating}',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          const SizedBox(height: 16),
          Text('Categories:',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          _buildCategoryList(restaurant.categories),
          const SizedBox(height: 16),
          Text('Menus:',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          _buildMenuList(restaurant.menus),
          const SizedBox(height: 16),
          Text('Customer Reviews:',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
          _buildCustomerReviewsList(restaurant.customerReviews),
        ],
      ),
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 8.0,
      children: categories
          .map((category) => Chip(label: Text(category.name)))
          .toList(),
    );
  }

  Widget _buildMenuList(Menus menus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Foods:',
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
        _buildItemList(menus.foods.map((food) => food.name).toList()),
        const SizedBox(height: 8),
        Text('Drinks:',
            style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
        _buildItemList(menus.drinks.map((drink) => drink.name).toList()),
      ],
    );
  }

  Widget _buildItemList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => Text(item)).toList(),
    );
  }

  Widget _buildCustomerReviewsList(List<CustomerReview> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: reviews
          .map((review) => Text(
              '${review.name}: ${review.review} (${review.date})',
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)))
          .toList(),
    );
  }
}
