import 'package:flutter_subm2_getx/modules/home/home_controller.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';

class BottomBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(HomeController(apiService: Get.find<ApiService>()));
  }
}
