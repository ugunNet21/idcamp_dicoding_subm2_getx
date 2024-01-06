import 'package:flutter_subm2_getx/modules/detail/detail_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';

class DetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.lazyPut<DetailController>(
        () => DetailController(apiService: Get.find<ApiService>()));
  }
}
