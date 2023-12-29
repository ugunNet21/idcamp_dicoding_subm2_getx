import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_subm2_getx/modules/search/search_controller.dart'
    as MySearchController;
// import 'package:flutter_subm2_getx/models/restaurant.dart';

class SearchView extends StatelessWidget {
  final MySearchController.SearchController controller = Get.find();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Restaurants'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    controller.searchRestaurants(searchController.text);
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
                  return ListTile(
                    title: Text(restaurant.name),
                    subtitle: Text(restaurant.description),
                    // Other UI components based on search results
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
