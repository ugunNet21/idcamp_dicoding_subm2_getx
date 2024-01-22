import 'package:flutter_subm2_getx/modules/schedul/notification_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController(apiService: Get.find()));
    Get.put(GetStorage());
  }
}
