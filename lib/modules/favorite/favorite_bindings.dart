import 'package:flutter_subm2_getx/modules/favorite/favorite_controller.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class FavoriteBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.lazyPut<FavoriteController>(
      () => FavoriteController(apiService: Get.find<ApiService>()),
    );
  }
}
