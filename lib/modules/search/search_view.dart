import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:flutter_subm2_getx/themes/themes.dart';
import 'package:get/get.dart';
import 'package:flutter_subm2_getx/modules/search/search_controller.dart'
    // ignore: library_prefixes
    as MySearchController;

class SearchView extends StatelessWidget {
  final MySearchController.SearchController controller = Get.find();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurants',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        controller.isLoading(true);
                        await controller
                            .searchRestaurants(searchController.text);
                        controller.isLoading(false);
                      }
                    },
                  ),
                ),
              ),
            ),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return const CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final restaurant = controller.searchResults[index];
                        return buildSearchResultItem(restaurant);
                      },
                    ),
                  );
                }
              },
            ),
            if (controller.error.value.contains('No internet connection.'))
              ElevatedButton(
                onPressed: () {
                  controller.setError('');
                  controller.searchRestaurants(searchController.text);
                },
                child: const Text('Try Again'),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchResultItem(Restaurant restaurant) {
    return ListTile(
      title: Text(restaurant.name),
      onTap: () {
        controller.navigateToDetail(restaurant.id);
      },
    );
  }
}
