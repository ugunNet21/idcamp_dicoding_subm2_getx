import 'package:flutter/material.dart';
import 'package:flutter_subm2_getx/models/restaurant.dart';
import 'package:get/get.dart';
import 'package:flutter_subm2_getx/modules/search/search_controller.dart'
    as MySearchController;
// import 'package:flutter_subm2_getx/models/restaurant.dart';

class SearchView extends StatelessWidget {
  final MySearchController.SearchController controller = Get.find();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurants'),
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
                    icon: Icon(Icons.search),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.searchRestaurants(searchController.text);
                      }
                    },
                  ),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.searchResults.length,
                  itemBuilder: (context, index) {
                    final restaurant = controller.searchResults[index];
                    return buildSearchResultItem(restaurant);
                  },
                ),
              ),
            ),
            // Tombol "Try Again" jika koneksi internet tidak aktif
            if (controller.error.value.contains('Tidak ada koneksi internet.'))
              ElevatedButton(
                onPressed: () {
                  controller.setError('');
                  controller.searchRestaurants(searchController.text);
                },
                child: Text('Try Again'),
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

