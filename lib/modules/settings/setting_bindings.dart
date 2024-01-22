import 'package:flutter_subm2_getx/modules/settings/setting_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController(apiService: Get.find()));
    Get.put(GetStorage());
    }
}