import 'package:flutter_subm2_getx/modules/search/search_controller.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class SearchBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController(apiService: ApiService()));
  }
}