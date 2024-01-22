import 'package:flutter_subm2_getx/modules/schedul/notification_controller.dart';
import 'package:flutter_subm2_getx/services/api_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingController extends GetxController {
  final ApiService apiService;
  final _storage = GetStorage();
  RxBool isReminderOn = true.obs;

  SettingController({required this.apiService});

  void toggleReminder() {
    isReminderOn.toggle();
    _storage.write('isReminderOn', isReminderOn.value);
    if (isReminderOn.value) {
      scheduleDailyNotification();
    } else {
      cancelDailyNotification();
    }
  }

  @override
  void onInit() {
    super.onInit();
    isReminderOn.value = _storage.read('isReminderOn') ?? true;
  }

  void scheduleDailyNotification() {
    DateTime notificationTime = DateTime(DateTime.now().year,
        DateTime.now().month, DateTime.now().day, 11, 0, 0);
    Get.find<NotificationController>().showRandomRestaurantNotification();
  }

  void cancelDailyNotification() {
    final notificationManager = Get.find<NotificationController>();
    notificationManager.cancelNotification();
  }
}
