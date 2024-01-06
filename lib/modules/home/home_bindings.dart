import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(apiService: ApiService()));
  }
}